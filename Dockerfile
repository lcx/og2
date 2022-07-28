ARG RUBY_VERSION
FROM ruby:$RUBY_VERSION-slim
MAINTAINER Cristian Livadaru

ARG BUNDLER_VERSION

RUN apt-get update -qq \
  && DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
    curl

RUN curl -sL https://deb.nodesource.com/setup_16.x | bash - \
  && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update -qq && DEBIAN_FRONTEND=noninteractive apt-get install -qq --no-install-recommends \
    vim cmake pkg-config nodejs libpq-dev git-core build-essential yarn && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    truncate -s 0 /var/log/*log

# RUN npm install yarn -g

# Configure bundler and PATH
ENV LANG=C.UTF-8 \
  GEM_HOME=/bundle \
  BUNDLE_JOBS=4 \
  BUNDLE_RETRY=3
ENV BUNDLE_PATH $GEM_HOME
ENV BUNDLE_APP_CONFIG=$BUNDLE_PATH \
  BUNDLE_BIN=$BUNDLE_PATH/bin
ENV PATH /app/bin:$BUNDLE_BIN:$PATH

# Upgrade RubyGems and install required Bundler version
RUN gem update --system && \
    gem install bundler:$BUNDLER_VERSION

EXPOSE 5000

VOLUME ["/app/log/"]

WORKDIR /app
COPY Gemfile* ./

RUN bundle config set without 'development test'
RUN bundle install

COPY . .

# RUN yarn install

ENV RAILS_ENV production

# RUN SECRET_KEY_BASE="$(bundle exec rails secret)" DB_ADAPTER=nulldb \
# bundle exec rails assets:precompile

ENTRYPOINT ["/app/docker-entry.sh"]
CMD ["rails","server","-b","0.0.0.0","-p","5000"]
