FROM node:18-alpine

RUN apk add bash dumb-init curl python3 git
RUN curl -s https://raw.githubusercontent.com/Intervox/node-webp/latest/bin/install_webp | bash
RUN apk add --no-cache --update libwebp-tools
RUN apk add --no-cache --update libpng-dev libjpeg-turbo-dev giflib-dev tiff-dev autoconf automake make gcc g++ wget
RUN wget --no-check-certificate https://storage.googleapis.com/downloads.webmproject.org/releases/webp/libwebp-1.0.0.tar.gz && \
      tar -xvzf libwebp-1.0.0.tar.gz && \
      cd libwebp-1.0.0 && \
      ./configure && \
      make && \
      make install && \
      cd .. && \
      rm -rf libwebp-1.0.0 libwebp-1.0.0.tar.gz

RUN mkdir /usr/app && \
    mkdir /usr/app/dist && \
    chown -R node:node /usr/app && \
    chown -R node:node /usr/local/lib/node_modules && \
    chown -R node:node /usr/local/bin
