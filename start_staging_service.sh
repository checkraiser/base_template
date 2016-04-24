#!/usr/bin/env bash

NODE_ENV=staging forever start ./realtime/realtime-server.js
rm -f ~/code/tg/tele.sock
TELEGRAM_ENV=staging ruby telegram_control.rb start

