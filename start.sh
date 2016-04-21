#!/usr/bin/env bash

bin/rake bower:install['--allow-root']
#NODE_ENV=development forever start ./realtime/realtime-server.js
bin/rails s


