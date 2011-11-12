namespace :install do
  desc "Installing transmission-daemon, since we're testing interaction with it"
  task :transmission_daemon do
    puts '* Adding transmission PPA'
    `sudo apt-add-repository ppa:transmissionbt/ppa`
    puts '* Updating deb cache'
    `sudo apt-get update`
    puts '* installing transmission-daemon'
    `sudo apt-get install transmission-daemon`
  end

  desc "Install bundler pre to speed up bundle install"
  task :bundler_pre do
    `gem install bundler --pre`
  end
end
