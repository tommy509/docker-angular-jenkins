# Stage 1
FROM node:12.16.2-stretch-slim as build-step
RUN mkdir -p /app
WORKDIR /app
COPY package.json /app
RUN node -v
RUN npm install 
COPY . /app
RUN npm run build 
# Stage 2
FROM nginx:1.20.1
COPY --from=build-step /app/dist/app/ /usr/share/nginx/html