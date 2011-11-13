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

  desc "Init default (example) installation"
  task :config_init do
    `cp #{File.join(Rails.root, 'config', 'transmission.example.yml')} #{File.join(Rails.root, 'config', 'transmission.yml')}`
    `cp #{File.join(Rails.root, 'config', 'database.example.yml')} #{File.join(Rails.root, 'config', 'database.yml')}`
  end
end
