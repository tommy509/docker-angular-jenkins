# Stage 1
FROM node:14.18.1 as build-step
RUN mkdir -p /app
WORKDIR /app
COPY package.json /app
RUN npm install -g yarn
RUN node -v
RUN npm install 
COPY . /app
RUN npm run build --prod
# Stage 2
FROM nginx:1.20.1
COPY --from=build-step /app/dist/app/ /usr/share/nginx/html