class Downloader::Transmission

  def initialize
    @config = YAML::load(IO.read(File.join(Rails.root, 'config', 'transmission.yml')))

    @server_uri = URI("http://#{@config['host']}:#{@config['port']}/transmission/rpc")

    @agent = Net::HTTP.new(@config['host'], @config['port'])
  end

  def get(*args)
  end

  def start(*args)
  end

  def stop(*args)
  end

  def verify(*args)
  end

  def reannounce(*args)
  end

  private

  def send(method, *args)
    params = args.extract_options!

    req = Net::HTTP::Post.new( @server_uri.path )
    req.basic_auth @config['username'], @config['password']

    query = {}
    query[:method] = method
    query[:arguments] = params if params

    req.body = JSON.generate(query)

    begin
      response = @agent.request(req)
      raise unless response.is_a?(Net::HTTPSuccess)

    rescue
      req['X-Transmission-Session-Id'] = response['X-Transmission-Session-Id']
      retry if _r ||= 0 and _r += 1 and _r == 1
      raise response.body
    end

    JSON.parse( response.body )
  end

end
