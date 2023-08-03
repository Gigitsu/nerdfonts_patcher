FROM alpine:latest

ARG NERD_FONTS_VERSION

RUN apk update && apk upgrade && \
    apk add --no-cache fontforge --repository=https://dl-cdn.alpinelinux.org/alpine/latest-stable/community && \
    apk add --no-cache curl git py3-pip unzip zip && \
    pip install configparser

RUN curl -L https://github.com/ryanoasis/nerd-fonts/releases/download/v${NERD_FONTS_VERSION}/FontPatcher.zip -o FontPatcher.zip && \
    unzip FontPatcher.zip -d /patcher && \
    rm -f FontPatcher.zip

ENV PYTHONIOENCODING=utf-8

ENV NERD_FONTS_VERSION=${NERD_FONTS_VERSION}

WORKDIR /patcher