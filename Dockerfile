# build the app
FROM node:latest AS builder
WORKDIR /app
COPY ./ ./
RUN npm install -g @ionic/cli
RUN npm install
RUN npm run-script build
# setup server
#FROM nginx:latest
FROM nginxinc/nginx-unprivileged
user root
RUN rm -rf /usr/share/nginx/html/*
COPY --from=builder /app/www/ /usr/share/nginx/html/
# COPY nginx.conf /etc/nginx/nginx.conf
user 101
EXPOSE 8080
CMD ["nginx", "-g", "daemon off;"]