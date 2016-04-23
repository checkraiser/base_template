#!/usr/bin/env bash

forever stop ./realtime/realtime-server.js
ruby telegram_control.rb stop

