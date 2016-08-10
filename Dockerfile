FROM ruby:2.3-slim
MAINTAINER Jon Gold <jon.gold@airbnb.com>

RUN apt-get update -qq && apt-get install -qq -y --no-install-recommends \
  build-essential \
  libpq-dev \
  imagemagick

ENV APP_HOME /app
ENV HOME /root
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME
COPY Gemfile* $APP_HOME/
RUN bundle install

COPY . $APP_HOME

RUN mkdir -p $HOME/tmp/cache/{meta,body}
