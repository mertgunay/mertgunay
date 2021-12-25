FROM python:3.9-slim as builder

ENV PYTHONUNBUFFERED 1

RUN apt-get -y update \
  && apt-get install -y gettext \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

COPY requirements.lock.txt app/requirements.lock.txt
WORKDIR /app

RUN pip install --upgrade pip && \
    pip install -r requirements.lock.txt

FROM python:3.9-slim as base-build

ENV PYTHONUNBUFFERED 1
LABEL maintainer="mertgunay.com"

RUN groupadd -r mertgunay && useradd -r -g mertgunay mertgunay

COPY --from=builder /usr/local/lib/python3.9/site-packages/ /usr/local/lib/python3.9/site-packages/
COPY --from=builder /usr/local/bin/ /usr/local/bin/

RUN mkdir /app
WORKDIR /app

RUN chown -R mertgunay:mertgunay /app
USER mertgunay

COPY . /app
WORKDIR /app
EXPOSE 8000

FROM base-build as development

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]

FROM base-build as production

CMD ["gunicorn", "--bind", "0.0.0.0:8000", "--workers", "3", "mertgunay.wsgi:application"]
