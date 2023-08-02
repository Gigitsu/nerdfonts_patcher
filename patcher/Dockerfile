FROM alpine:latest

ARG NERD_FONTS_VERSION
ARG FONT_FORGE_VERSION

RUN apk update && apk upgrade && \
    apk add --no-cache fontforge=${FONT_FORGE_VERSION} --repository=https://dl-cdn.alpinelinux.org/alpine/latest-stable/community && \
    apk add --no-cache curl py3-pip unzip && \
    pip install configparser

RUN curl -L https://github.com/ryanoasis/nerd-fonts/releases/download/v${NERD_FONTS_VERSION}/FontPatcher.zip -o FontPatcher.zip && \
    unzip FontPatcher.zip -d /patcher && \
    rm -f FontPatcher.zip

ENV PYTHONIOENCODING=utf-8

WORKDIR /patcher