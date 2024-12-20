FROM python:3.11-alpine

RUN apk add --no-cache \
  curl \
  sed \
  libpq-dev \
  gcc \
  musl-dev \
  && rm -rf /var/cache/apk/*

WORKDIR /usr/src/app

ENV POETRY_HOME=/usr/local/share/pypoetry
ENV POETRY_VIRTUALENVS_CREATE=false

RUN ["/bin/sh", "-c", "set -o pipefail && curl -sSL https://install.python-poetry.org | python3 -"]

COPY ./UltimaScraper .
RUN /usr/local/share/pypoetry/bin/poetry update
RUN sed -i '/if asset.urls:/a\                if asset.__content_metadata__.__soft__.get_author().id == authed.id:\n                    continue' /usr/local/lib/python3.11/site-packages/ultima_scraper_collection/managers/datascraper_manager/datascrapers/onlyfans.py
COPY ./__init__.py /usr/local/lib/python3.11/site-packages/ultima_scraper_api/apis/onlyfans

CMD [ "/usr/local/share/pypoetry/bin/poetry", "run", "python", "./start_us.py" ]
