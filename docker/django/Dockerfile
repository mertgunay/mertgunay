FROM python:3.9-slim-buster as builder

ENV PYTHONUNBUFFERED 1

RUN apt-get -y update \
  && apt-get install -y gettext \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

ARG DOCKER_ENV_MODE="production"
ENV DOCKER_ENV_MODE="${DOCKER_ENV_MODE}"

COPY Pipfile app/Pipfile
COPY Pipfile.lock app/Pipfile.lock

WORKDIR /app

RUN pip install --upgrade pip && \
    pip install pipenv

RUN if [ "${DOCKER_ENV_MODE}" != "development" ] ; then \
    pipenv install --system --deploy --ignore-pipfile; else \
    pipenv install --system --deploy --ignore-pipfile --dev; fi


FROM python:3.9-slim-buster as base-build

ENV PYTHONUNBUFFERED 1
LABEL maintainer="mertgunay.com"

RUN groupadd -r mertgunay && useradd -r -g mertgunay mertgunay

COPY --from=builder /usr/local/lib/python3.9/site-packages/ /usr/local/lib/python3.9/site-packages/
COPY --from=builder /usr/local/bin/ /usr/local/bin/

RUN mkdir -p /app/src && \
    mkdir /app/static && \
    mkdir /app/media

WORKDIR /app/src

RUN chown -R mertgunay:mertgunay /app
USER mertgunay

# Copy entrypoint.sh
COPY docker/django/entrypoint.sh /app/entrypoint.sh
RUN sed -i 's/\r$//g' /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

COPY docker/django/start.sh /app/start.sh
RUN sed -i 's/\r//' /app/start.sh
RUN chmod +x /app/start.sh

EXPOSE 8000

COPY . .

ENTRYPOINT ["/app/entrypoint.sh"]
