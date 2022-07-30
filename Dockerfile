FROM node:16 as builder

USER node
RUN mkdir -p /home/node/app

WORKDIR '/home/node/app'

COPY --chown=node ./package.json ./
RUN npm install

COPY --chown=node:node ./ ./

RUN npm run build

FROM nginx:1.23.1
COPY --from=builder /home/node/app/build /usr/share/nginx/html