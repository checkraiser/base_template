#!/usr/bin/env bash

bin/rake bower:install['--allow-root']
forever start ./realtime/realtime-server.js
bin/rails s -b '0.0.0' -p 3100

