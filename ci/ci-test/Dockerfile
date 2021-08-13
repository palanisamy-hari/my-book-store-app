FROM ruby:2.6

WORKDIR /workspace

COPY Gemfile ./

RUN gem install bundler -v "2.2.16"
RUN gem install ffi
RUN bundle install
