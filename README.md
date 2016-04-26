== Installation

=== On local machine

- Install DockerToolbox

- Run commands

```
docker-machine create --driver virtualbox
docker-machine start
docker-machine env
eval $(docker-machine env)
docker-compose up
```

- Go to `http://192.168.99.100` to run


=== On Digital Ocean

=== Running

Each time running, just run:

```
docker-machine start
eval $(docker-machine env)
In one terminal: docker-compose up
In another terminal: docker-compose run mytelegram ./start_telegram
```

Visit `http://192.168.99.100` to run