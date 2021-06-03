FROM ruby:2.6.3
RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    nodejs npm && npm install n -g && n 10.24.0
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install yarn
WORKDIR /michigan-kuchikomi
COPY Gemfile Gemfile.lock /michigan-kuchikomi/
RUN bundle install