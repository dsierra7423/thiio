# random-http/Dockerfile
FROM node:14-alpine

WORKDIR /app

COPY . /app

RUN npm install

EXPOSE 80

CMD ["node", "index.js"]
