FROM node:12.16.2-stretch-slim AS build
COPY . /app
WORKDIR /app
RUN npm install && npm run build:prod && rm -rf node_modules/

FROM nginx:1.17.9-alpine as runtime
COPY --from=build /app/default.conf /etc/nginx/conf.d/
COPY --from=build /app/dist/ /var/www
EXPOSE 80