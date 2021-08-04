ARG BASE_IMAGE
FROM ${BASE_IMAGE}

WORKDIR /workspace

COPY Gemfile* ./

RUN gem install bundler -v "2.2.16"
RUN bundle install
