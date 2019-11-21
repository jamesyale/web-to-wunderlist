FROM ruby:2.3

COPY Gemfile /tmp/Gemfile

WORKDIR /tmp

RUN bundle install

WORKDIR /app

ARG CACHE_DATE=not_a_date

COPY ./* /app/

CMD bundle exec ruby app.rb