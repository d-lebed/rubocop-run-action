FROM ruby:3.4.8-alpine

WORKDIR /rubocop

COPY Gemfile Gemfile.lock /rubocop/

RUN apk add --no-cache --virtual .ruby-builddeps \
        alpine-sdk \
        cmake \
        openssl \
        openssl-dev \
    ; \
    bundle install --jobs 20 --retry 5 \
    ; \
    find /usr/local/bundle/cache/ -name "*.gem" -delete \
    && find /usr/local/bundle/gems/ -type f \( -name "*.c" -o -name "*.o" \) -delete \
    ; \
    apk del --purge .ruby-builddeps

RUN apk add --no-cache jq

COPY entrypoint.sh /rubocop/
COPY lib /rubocop/lib

WORKDIR /code

ENV BUNDLE_GEMFILE=/rubocop/Gemfile

ENTRYPOINT ["/rubocop/entrypoint.sh"]
