# Stage 1
FROM node:14.18.1-alpine as build-step
RUN mkdir -p /app
WORKDIR /app
COPY package.json /app
RUN npm cache clean --force
RUN npm uninstall @angular-devkit/build-angular
RUN npm install @angular-devkit/build-angular
RUN ng update --all --allow-dirty --force
RUN npm install npm@latest -g
COPY . /app
RUN npm run build --prod
# Stage 2
FROM nginx:1.20.1
COPY --from=build-step /dist/pos /usr/share/nginx/html