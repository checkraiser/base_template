#!/usr/bin/env bash

docker-compose up -d
echo "Please wait some seconds..."
sleep 5
docker-compose run mytelegram1 ./start_telegram.sh -d