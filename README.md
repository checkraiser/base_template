## Installation

### On local machine

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


### On Digital Ocean

## Running

Each time running, just run:

```
docker-machine start
eval $(docker-machine env)
./start_all_docker.sh
```

Visit `http://192.168.99.100` to run

## Troubleshooting

- Rebuild images when pull new commit: `./rebuild_all_docker.sh`