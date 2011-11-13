  require 'ostruct'

  module Downloader::Transmission
    FIELDS = ["error","errorString","eta","id","isFinished","leftUntilDone","name","peersGettingFromUs","peersSendingToUs","rateDownload",
        "rateUpload","sizeWhenDone","status","uploadRatio",'files', 'fileStats', 'percentDone', 'hashString']

    class StateResponse
      def initialize(text)
        @data = JSON.parse(text)

        raise "Torrent not found" if @data['arguments']['torrents'].blank?
        #TODO: add checks
      end

      def eta
        @data['arguments']['torrents'].first['eta']
      end

      def status
        @data['arguments']['torrents'].first['status']
      end

      #delme after development
      attr_accessor :data
    end

    extend self

    def state(torrent_id)
      StateResponse.new get_torrents_by(:ids => [torrent_id])
    end

    def create(torrent_file)
      torrent_file = torrent_file.read
      response = send 'torrent-add', :metainfo => Base64.encode64(torrent_file)
      response = JSON.parse response

      if response['result'] == 'duplicate torrent'
        Digest::SHA1.hexdigest( BEncode.load(torrent_file)["info"].bencode )
      else
        response['arguments']['torrent-added']['hashString']
      end
    end

    def start(torrent_id)
      return false unless torrent_id
      send 'torrent-start', :ids => [torrent_id]
    end

    def stop(torrent_id)
      return false unless torrent_id
      send 'torrent-stop', :ids => [torrent_id]
    end

    def remove(torrent_id)
      return false unless torrent_id
      send 'torrent-remove', :ids => [torrent_id], "delete-local-data" => true
    end

    private

    def get_torrents_by(*args)
      options = args.extract_options!
      options[:fields] = FIELDS
      send('torrent-get', options)
    end

    def config
      @config ||= YAML::load(IO.read(File.join(Rails.root, 'config', 'transmission.yml')))
    end

    def agent
      @agent ||= Net::HTTP.new(@config['host'], @config['port'])
    end

    def send(method, *args)
      params = args.extract_options!

      req = Net::HTTP::Post.new( "/transmission/rpc" )
      req.basic_auth config['username'], config['password']

      query = {}
      query[:method] = method
      query[:arguments] = params if params

      req.body = JSON.generate(query)

      begin
        response = agent.request(req)
        raise unless response.is_a?(Net::HTTPSuccess)
      rescue
        req['X-Transmission-Session-Id'] = response['X-Transmission-Session-Id']
        #Retry only once
        retry if _r ||= 0 and _r += 1 and _r == 1
        raise response.body
      end

      response.body
    end

  end
