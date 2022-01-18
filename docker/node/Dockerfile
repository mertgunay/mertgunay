FROM node:17-stretch-slim

COPY package.json app/src/package.json
WORKDIR /app/src

RUN npm install && npm cache clean --force

ENV PATH /app/node_modules/.bin/:$PATH