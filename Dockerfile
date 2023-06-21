FROM node:20

WORKDIR /app
COPY reveal.js /app
RUN npm install

ENTRYPOINT [ "npm", "start", "--", "--host", "0.0.0.0" ]