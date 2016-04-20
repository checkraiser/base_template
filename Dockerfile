FROM ruby:2.3
MAINTAINER checkraiser11@gmail.com


RUN apt-get update && apt-get install -y \
    libreadline-dev\
    libconfig-dev\
    libssl-dev\
    lua5.2\
    liblua5.2-dev\
    libevent-dev\
    libjansson-dev\
    libpython-dev\
    make

RUN \
  cd /tmp && \
  wget http://nodejs.org/dist/node-latest.tar.gz && \
  tar xvzf node-latest.tar.gz && \
  rm -f node-latest.tar.gz && \
  cd node-v* && \
  ./configure && \
  CXX="g++ -Wno-unused-local-typedefs" make && \
  CXX="g++ -Wno-unused-local-typedefs" make install && \
  cd /tmp && \
  rm -rf /tmp/node-v* && \
  npm install -g npm && \
  printf '\n# Node.js\nexport PATH="node_modules/.bin:$PATH"' >> /root/.bashrc
# Default settings
ENV RAILS_ENV development
ENV APP_HOME /usr/src/funnelchat

# Set up working dirs
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME

RUN useradd -ms /bin/bash telegramd
RUN chown -R telegramd /tmp
RUN \
    cd /tmp && \
    git clone --recursive https://github.com/vysheng/tg.git && \
    cd tg && \
    ./configure && \
    make && \
    cd $APP_HOME
# Set up gems
COPY Gemfile* $APP_HOME/
COPY ./config/tg_server.pub /tmp/
COPY ./telegram_daemon.rb /tmp/
ENV BUNDLE_PATH /gems
ENV NODE_PATH /node_modules
RUN \
    cd /tmp && \
    git clone https://github.com/ssut/telegram-rb && \
    cd telegram-rb && \
    bundle check || bundle install && \
    gem build telegram-rb.gemspec && \
    gem install telegram-rb-0.1.0.gem

RUN bundle check || bundle install
COPY package.json $APP_HOME/
RUN npm install
RUN npm install -g bower
RUN npm install -g forever
EXPOSE 3100
CMD ["./start.sh"]

