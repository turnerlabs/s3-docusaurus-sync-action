FROM python:3.6-alpine

LABEL version="1.0.0"

# https://github.com/aws/aws-cli/blob/master/CHANGELOG.rst
ENV AWSCLI_VERSION='1.17.12'
RUN pip install --quiet --no-cache-dir awscli==${AWSCLI_VERSION}

RUN apk add autoconf
RUN apk add --update nodejs npm
RUN apk add --update npm

RUN apk update && \
    apk upgrade && \
    apk add --no-cache \
    git \
    openssl \
    openssh-client \
    autoconf \
    automake \
    bash \
    g++ \
    libc6-compat \
    libjpeg-turbo-dev \
    libpng-dev \
    make \
    nasm
# We need these deps for git and docusaurus

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]