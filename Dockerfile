FROM ruby:2.6

# Register Yarn package source.
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

# Install additional packages.
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs npm && \
apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN npm install --global yarn

# Prepare working directory.
WORKDIR /app

COPY ./.docker/Gemfile /app/Gemfile
COPY ./.docker/Gemfile.lock /app/Gemfile.lock

RUN gem install bundler
# RUN gem install rails -v '5.2.6'

RUN bundle install

COPY . /app

# RUN rails webpacker:install:react
# RUN rails generate react:install

# # Configure endpoint.
COPY ./.docker/entrypoint.sh /usr/bin/

RUN chmod +x /usr/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# # Start app server.
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
# CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
