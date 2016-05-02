#!/usr/bin/env bash

docker-compose rm -fv rb4 && docker-compose build rb4
docker-compose rm -fv mytelegram1 && docker-compose build mytelegram1