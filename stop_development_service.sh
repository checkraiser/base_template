#!/usr/bin/env bash

NODE_ENV=development forever stop ./realtime/realtime-server.js
TELEGRAM_ENV=development ruby telegram_control.rb stop

