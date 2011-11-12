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
end

namespace :test do
  desc "Shortcut for Travis CI testing"
  task :ci => ["db:create", "db:migrate", "db:test:prepare", "spec", "install:transmission_daemon"]
end
