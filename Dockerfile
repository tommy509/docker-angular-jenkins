# Stage 1
FROM node:latest as build-step
RUN mkdir -p /app
WORKDIR /app
COPY package.json /app
RUN npm uninstall @angular/compiler-cli@13.0.0-rc.0
RUN npm install 
COPY . /app
RUN npm run build --prod
# Stage 2
FROM nginx:1.20.1
COPY --from=build-step /dist/pos /usr/share/nginx/html