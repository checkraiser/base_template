#!/usr/bin/env bash

cd $APP_HOME
telegram-cli -k tg_server.pub -vvvv -L tmp
ruby telegram_daemon.rb > /dev/null &