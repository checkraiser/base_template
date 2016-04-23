#!/usr/bin/env bash

forever start ./realtime/realtime-server.js
ruby telegram_control.rb start

