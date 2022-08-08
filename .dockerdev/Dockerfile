FROM ruby:3.1.2-alpine

RUN apk add --no-cache \
        alpine-sdk \
        cmake \
        openssl \
        openssl-dev \
        jq

WORKDIR /code

ENV BUNDLE_GEMFILE=/code/Gemfile

CMD ["/code/entrypoint.sh"]
