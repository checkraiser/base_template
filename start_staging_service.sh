#!/usr/bin/env bash

NODE_ENV=staging forever start ./realtime/realtime-server.js
TELEGRAM_ENV=staging ruby telegram_control.rb start

