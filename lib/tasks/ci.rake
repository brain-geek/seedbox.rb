namespace :test do
  desc "Shortcut for Travis CI testing"
  task :ci => ["install:transmission_daemon", "install:config_init", "db:create", "db:migrate", "db:test:prepare", "spec"]
end
