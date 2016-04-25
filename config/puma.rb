environment ENV['RAILS_ENV'] || 'production'
#daemonize

workers    2 # should be same number of your CPU core
threads    1, 6
bind       'tcp://0.0.0.0:3100'
pidfile    "/var/run/puma_app1.pid"