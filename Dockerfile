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
# Set up gems
COPY Gemfile* $APP_HOME/
ENV BUNDLE_PATH /gems
ENV NODE_PATH /node_modules
RUN bundle check || bundle install
COPY package.json $APP_HOME/
RUN npm install
RUN npm install -g bower
RUN npm install -g forever
RUN bin/rake bower:install['--allow-root']
EXPOSE 3100
CMD ["./start.sh"]

