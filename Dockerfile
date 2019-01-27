FROM ruby:2.6.0

ENV APP_ROOT /www/pure-ruby-practice

WORKDIR $APP_ROOT

RUN apt-get update && \
    rm -rf /var/lib/apt/lists/*

COPY Gemfile $APP_ROOT
COPY Gemfile.lock $APP_ROOT

RUN \
  echo 'gem: --no-document' >> ~/.gemrc && \
  bundle config --global jobs 4 && \
  bundle install && \
  rm -rf ~/.gem

CMD ["ruby", "app.rb"]
