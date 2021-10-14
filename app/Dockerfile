# Stage 1
# FROM node:14-alpine as build-step
#RUN mkdir -p /app
#WORKDIR /app
#COPY package.json /app
#RUN npm install
#COPY . /app
#RUN npm run build --prod
# Stage 2
#FROM nginx:1.17.1-alpine
#COPY --from=build-step /app/dist/pos /usr/share/nginx/html
FROM jenkins/jenkins:2.303.2-jdk11
USER root
RUN apt-get update && apt-get install -y apt-transport-https \
       ca-certificates curl gnupg2 \
       software-properties-common
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
RUN apt-key fingerprint 0EBFCD88
RUN add-apt-repository \
       "deb [arch=amd64] https://download.docker.com/linux/debian \
       $(lsb_release -cs) stable"
RUN apt-get update && apt-get install -y docker-ce-cli
USER jenkins
RUN jenkins-plugin-cli --plugins "blueocean:1.25.0 docker-workflow:1.26"