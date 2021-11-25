# build the app
FROM node:latest AS builder
ENV "NODE_OPTIONS"="--openssl-legacy-provider"
WORKDIR /app
COPY ./ ./
RUN npm install -g @ionic/cli
RUN npm install
RUN npm run-script build

# setup http server on port 8080
# FROM httpd:latest
FROM image-registry.openshift-image-registry.svc:5000/openshift/httpd:latest
# RUN sed -i "s/80/8080/g" /usr/local/apache2/conf/httpd.conf
#COPY --from=builder /app/www/ /usr/local/apache2/htdocs/
COPY --from=builder /app/www/ /var/www/html/
EXPOSE 8080
#CMD ["httpd-foreground"]
CMD ["run-httpd"]
