# Stage 1
FROM node:14.18.1 as build-step


WORKDIR /opt/ng

COPY .npmrc package.json yarn.lock ./

RUN yarn install

ENV PATH="./node_modules/.bin:$PATH" 

COPY . ./

RUN ng build --prod

FROM nginx
COPY docker/nginx/default.conf /etc/nginx/conf.d/default.conf
COPY --from=compile-image /opt/ng/dist/app /usr/share/nginx/html