# build the app
FROM node:latest AS builder
WORKDIR /app
COPY ./ ./
RUN npm install -g @ionic/cli
RUN npm install
RUN npm run-script build

# setup http server on port 8080
FROM httpd:latest
RUN sed -i "s/80/8080/g" /usr/local/apache2/conf/httpd.conf
COPY --from=builder /app/www/ /usr/local/apache2/htdocs/
EXPOSE 8080
RUN chmod +w /usr/local/apache2/logs
CMD ["httpd-foreground"]
