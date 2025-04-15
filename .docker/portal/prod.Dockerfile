# pull official base image
FROM node:20.17.0-alpine

ARG SERVER_ENVIRONMENT
# Add Repositories
RUN rm -f /etc/apk/repositories &&\
    echo "http://dl-cdn.alpinelinux.org/alpine/v3.12/main" >> /etc/apk/repositories && \
    echo "http://dl-cdn.alpinelinux.org/alpine/v3.12/community" >> /etc/apk/repositories

RUN apk update && apk add --no-cache  \
    libzip-dev \
    bzip2-dev \
    libwebp-dev \
    zip \
    bash \
    icu-dev \
    zlib-dev \
    curl-dev \
    git \
    vim \
    nano 

RUN npm install --global pm2


COPY ./portal /usr/src/portal
COPY ./.docker/portal/init.sh /usr/src/init.sh

WORKDIR /usr/src/portal

RUN npm install
RUN chmod +x /usr/src/init.sh
RUN npm cache clean --force
RUN npm run build

EXPOSE 3000

#USER node
ENTRYPOINT ["/usr/src/init.sh"]

