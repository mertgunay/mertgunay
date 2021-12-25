FROM node:17-stretch-slim

COPY package.json app/package.json
WORKDIR /app

RUN npm install && npm cache clean --force

ENV PATH /app/node_modules/.bin/:$PATH