namespace :test do
  desc "Shortcut for Travis CI testing"
  task :ci => ["db:create", "db:migrate", "db:test:prepare", "spec"]
end
