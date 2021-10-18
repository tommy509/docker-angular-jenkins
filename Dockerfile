FROM node:12.7-alpine AS build
WORKDIR /app
COPY / ./
COPY package*.json ./

RUN npm install -g @angular/cli@10.0.4 && \
    npm install --force && \
    ng build
COPY . .
# Stage 2
FROM nginx:1.20.1
COPY --from=build-step /app/dist/app/ /usr/share/nginx/html