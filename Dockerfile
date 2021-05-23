# build the app
FROM node:latest AS builder
WORKDIR /app
COPY . /app
RUN npm install -g ionic
RUN npm install
RUN npm run-script build
# setup server
FROM nginx:latest
RUN rm -rf /usr/share/nginx/html/*
COPY --from=builder /app/www/ /usr/share/nginx/html/
COPY nginx.conf /etc/nginx/
EXPOSE 8080
CMD ["nginx", "-g", "daemon off;"]