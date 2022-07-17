#stage 1
FROM node:16.15-alpine3.14 as node
WORKDIR build
COPY . .
RUN npm install
RUN npm run build --omit=dev
#stage 2
FROM nginx:alpine
COPY --from=node build/dist/simple-chat-server-frontend/* /usr/share/nginx/html/
COPY --from=node build/start-app.sh /start-app.sh
RUN chmod 777 /start-app.sh
ENTRYPOINT ./start-app.sh

