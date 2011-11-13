namespace :test do
  desc "Shortcut for Travis CI testing"
  task :ci => ["install:transmission_daemon", "db:create", "db:migrate", "db:test:prepare", "spec"]
end
