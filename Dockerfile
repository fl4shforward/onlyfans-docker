FROM python:3.10-slim

RUN apt-get update && apt-get install -y \
  curl \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/app

ENV POETRY_HOME=/usr/local/share/pypoetry
ENV POETRY_VIRTUALENVS_CREATE=false

RUN ["/bin/bash", "-c", "set -o pipefail && curl -sSL https://install.python-poetry.org | python3 -"]

COPY ./OnlyFans .
#RUN pip install ultima-scraper-api #Should not be needed anymore
RUN /usr/local/share/pypoetry/bin/poetry install --without dev

CMD [ "/usr/local/share/pypoetry/bin/poetry", "run", "python", "./start_us.py" ]
