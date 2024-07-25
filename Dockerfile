FROM python:3.10-slim

RUN apt-get update && apt-get install -y \
  curl \
  gcc \
  libpq-dev \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/app

ENV POETRY_HOME=/usr/local/share/pypoetry
ENV POETRY_VIRTUALENVS_CREATE=false

RUN ["/bin/bash", "-c", "set -o pipefail && curl -sSL https://install.python-poetry.org | python3 -"]

COPY ./UltimaScraper .
RUN /usr/local/share/pypoetry/bin/poetry update && sed -i '/if asset.urls:/a\                if asset.__content_metadata__.__soft__.get_author().id == authed.id:\n                    continue' /usr/local/lib/python3.10/site-packages/ultima_scraper_collection/managers/datascraper_manager/datascrapers/onlyfans.py

CMD [ "/usr/local/share/pypoetry/bin/poetry", "run", "python", "./start_us.py" ]
