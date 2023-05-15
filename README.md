# NOTICE
Upstream is discontinued so I'm archiving too, obviously.

[DIGITALCRIMINALS explains why here.](https://github.com/DIGITALCRIMINALS/UltimaScraper/issues/983#issuecomment-1544000569)

# onlyfans-docker

Dockerized [DIGITALCRIMINALS/OnlyFans](https://github.com/DIGITALCRIMINALS/OnlyFans). Should autobuild new image on submodule update.

Please refer to his repo for config instructions.

## Sample docker-compose.yml
```
version: '3.8'
services:
  onlyfans:
    image: ghcr.io/fl4shforward/onlyfans
    volumes:
      - ./__user_data__:/usr/src/app/__user_data__
      - ./__settings__:/usr/src/app/__settings__
    environment:
      TZ: Europe/Paris
```
