source 'http://rubygems.org'

gem 'rails', '3.1.1'

gem 'sqlite3'

#Backend
gem 'activeadmin'
gem 'sass-rails'
gem 'meta_search',    '>= 1.1.0.pre'
gem 'paperclip'

#Error reporting
gem 'airbrake'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'coffee-rails', '~> 3.1.1'
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'
gem 'therubyracer'

gem 'ffaker'
gem 'factory_girl_rails', :require => false
#Gems used only for testing
group :development, :test do
  gem 'rspec-rails'
  gem 'shoulda'
  gem 'autotest'
  gem 'autotest-rails-pure', '4.1.2'
  gem 'ruby-debug19', :require => 'ruby-debug'

  #ruby-debug19 has bugs with 1.9.3, fixed in rubyforge release, but release is not present in rubygems
  #Installing:
  #	  wget http://rubyforge.org/frs/download.php/75414/linecache19-0.5.13.gem
  #   gem install linecache19-0.5.13.gem
  #   wget http://rubyforge.org/frs/download.php/75415/ruby-debug-base19-0.11.26.gem
  #   gem install ruby-debug-base19-0.11.26.gem -- --with-ruby-include=/home/`whoami`/.rvm/src/ruby-1.9.3-p0

  gem 'ruby-debug-base19', '~>0.11.26'
  gem 'linecache19', '~>0.5.13'
end


# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'
