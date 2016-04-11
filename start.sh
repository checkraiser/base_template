#!/usr/bin/env bash

rake bower:install['--allow-root']
NODE_ENV=development forever start ./realtime/realtime-server.js
rails s