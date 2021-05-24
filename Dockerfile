# build the app
FROM node:latest AS builder
WORKDIR /app
COPY ./ ./
RUN npm install -g @ionic/cli
RUN npm install
RUN npm run-script build
# serve content
EXPOSE 8080
CMD ["node", "server.js"]

# setup server

# FROM nginx:latest
# RUN rm -rf /usr/share/nginx/html/*
# COPY --from=builder /app/www/ /usr/share/nginx/html/
# COPY nginx.conf /etc/nginx/nginx.conf
# EXPOSE 8080
# CMD ["nginx", "-g", "daemon off;"]
# FROM httpd:latest
# RUN sed -i "s/80/8080/g" /usr/local/apache2/conf/httpd.conf
# COPY --from=builder /app/www/ /usr/local/apache2/htdocs/
# EXPOSE 8080
# CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]