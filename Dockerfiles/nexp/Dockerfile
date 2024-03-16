FROM node:21-alpine as base

RUN apk add dumb-init
RUN corepack enable
RUN corepack install --global pnpm@8.15.1

RUN apk add --no-cache --virtual .build-deps bash curl python3 \
  && curl -s https://raw.githubusercontent.com/Intervox/node-webp/latest/bin/install_webp | bash \
  && apk add --no-cache --update libwebp-tools libpng-dev libjpeg-turbo-dev giflib-dev tiff-dev autoconf automake make gcc g++ wget \
  && wget --no-check-certificate https://storage.googleapis.com/downloads.webmproject.org/releases/webp/libwebp-1.3.2.tar.gz \
  && tar -xvzf libwebp-1.3.2.tar.gz \
  && cd libwebp-1.3.2 \
  && ./configure \
  && make \
  && make install \
  && cd .. \
  && rm -rf libwebp-1.3.2 libwebp-1.3.2.tar.gz
