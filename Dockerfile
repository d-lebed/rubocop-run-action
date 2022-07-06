FROM ruby:3.1.2-alpine AS build

RUN apk --no-cache add make g++

WORKDIR /rubocop

COPY Gemfile .

RUN bundle install

FROM ruby:3.1.2-alpine

WORKDIR /rubocop

COPY --from=build /usr/local/bundle /usr/local/bundle
COPY --from=build /rubocop/* /rubocop/

COPY entrypoint.sh /rubocop/
COPY lib /rubocop/lib

WORKDIR /code

ENV BUNDLE_GEMFILE=/rubocop/Gemfile

ENTRYPOINT ["/rubocop/entrypoint.sh"]
