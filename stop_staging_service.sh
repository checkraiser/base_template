#!/usr/bin/env bash

NODE_ENV=staging forever stop ./realtime/realtime-server.js
TELEGRAM_ENV=staging ruby telegram_control.rb stop

