#!/bin/sh
echo "server { \
              listen       80; \
              server_name  chat.server.com; \
              location / { \
               root   /usr/share/nginx/html; \
               index  index.html; \
              } \
              location /api/ { \
                proxy_pass http://${IP:-localhost}:8080/api/; \
              } \
          }" > etc/nginx/conf.d/default.conf && \
           for f in $(find /usr/share/nginx/html -name "*.js.*"); do sed -i "s/some_ip/${IP:-localhost}/g" $f; done && \
           for f in $(find /usr/share/nginx/html -name "*.js"); do sed -i "s/some_ip/${IP:-localhost}/g" $f; done && \
           nginx -g 'daemon off;'