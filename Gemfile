source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.5.1'
# Use postgresql as the database for Active Record
gem 'rack-cors'
gem 'pg', '~> 0.15'
# Use SCSS for stylesheets
gem 'bootstrap-sass'
gem 'sass-rails', '~> 5.0'
gem "font-awesome-rails"
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'bower-rails'
gem 'haml-rails'
gem 'angular-rails-templates'
gem 'gon', '5.2.3'
#gem 'colorize'
gem 'devise'
# Use pg_search for postgreSQL search
gem 'pg_search'

# Use pundit for policy-based authorization
gem 'pundit'

# gem for readline required for rails console
gem 'rb-readline'

# Use ancestry to manage tree structures
#gem 'ancestry'

# Use Paranoia to manage soft-deletion
#gem "paranoia", "~> 2.0"
gem 'redis'
gem 'ng-rails-csrf'
gem 'delayed_job_active_record'
gem "facets", require: false
gem 'validates_email_format_of'
gem "daemons"

# Use Browser Details to add the user's browser information in logs
#gem 'browser_details'
#gem 'exception_notification'
#gem 'fog'

# Use Addressable for URI handling
gem 'addressable'
gem 'browser_details'

# Use Email Verifier for checking if an email address is real
#gem 'email_verifier'

# use rack-mini-profiler and Flamegraph for profiling
#gem 'rack-mini-profiler'
#gem 'flamegraph'

# use Safety Mailer to restrict email sending
#gem "safety_mailer"
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'
# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
gem "puma"
group :test do
  gem 'faker'
  gem 'launchy'
end
group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  gem "rspec-rails"
  gem "factory_girl_rails"
  gem "capybara"
  gem "database_cleaner"
  gem "poltergeist"
  gem "teaspoon-jasmine"
  gem 'phantomjs'
end

group :development  do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'brakeman', :require => false
  gem 'better_errors'
end

