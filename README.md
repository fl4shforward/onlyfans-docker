# onlyfans-docker

Dockerized [DIGITALCRIMINAL/UltimaScraper](https://github.com/DIGITALCRIMINAL/UltimaScraper). Should autobuild new image on submodule update.

Please refer to his repo for config instructions.

## Sample docker-compose.yml

```yml
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
