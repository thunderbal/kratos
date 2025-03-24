# thunderball/kratos

## Build

Check for releases available at https://github.com/ory/kratos/releases

```bash
VERSION=v1.3.1
docker build -t thunderball/kratos:${VERSION} --build-arg VERSION=${VERSION} .
```

## Quick start

```bash
docker build -t thunderball/kratos:dev .
docker network create kratos
docker volume create kratos
docker run -d  --name mysql --rm --net=kratos -v kratos:/var/lib/mysql -e MYSQL_RANDOM_ROOT_PASSWORD=yes -e MYSQL_DATABASE=kratos -e MYSQL_USER=kratos -e MYSQL_PASSWORD=kratos mysql:latest
docker run -it --name kratos-migrate --rm --net=kratos -v $PWD/config/kratos:/home/kratos:ro --read-only thunderball/kratos:dev -c /home/kratos/config.yml migrate sql -e
docker run -d  --name kratos --rm --net=kratos -p 4433:4433 -p 4434:4434 -v $PWD/config/kratos:/home/kratos:ro --read-only thunderball/kratos:dev serve --config /home/kratos/config.yml
```

## Kratos CLI

```bash
# Create kratos alias from folder containing docker-compose.yml file
alias kratos="docker compose -f $PWD/docker-compose.yml exec kratos kratos --endpoint http://localhost:4434"

kratos import identities /identities/david.json
kratos list identities
kratos get --format yaml identity 8451d689-2887-4f88-b911-5b3ebc2e3f51
```