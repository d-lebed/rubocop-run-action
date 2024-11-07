FROM ruby:3.3.6-alpine

RUN apk add --no-cache \
        alpine-sdk \
        cmake \
        openssl \
        openssl-dev \
        jq

WORKDIR /rubocop

ENV BUNDLE_GEMFILE=/rubocop/Gemfile

CMD ["/rubocop/entrypoint.sh"]
