# Stage 1
FROM node:14.18.1-alpine as build-step
RUN mkdir -p /app
WORKDIR /app
COPY package.json /app

RUN npm install -g npm-check-updates

RUN ncu -u
RUN npm update
RUN npm install 
COPY . /app
RUN npm run build --prod
# Stage 2
FROM nginx:1.20.1
COPY --from=build-step /dist/pos /usr/share/nginx/html