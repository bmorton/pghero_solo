FROM yammer/ruby:2.1.3
MAINTAINER Brian Morton "bmorton@yammer-inc.com"

# Install dependencies for gems
RUN apt-get update
# pg gem
RUN apt-get -y install libpq-dev

# Install PostgreSQL client
RUN locale-gen en_US.UTF-8
RUN curl https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main" >> /etc/apt/sources.list
RUN apt-get -y update && apt-get -y install postgresql-client

# Add and install gem dependencies
ADD Gemfile       /app/Gemfile
ADD Gemfile.lock  /app/Gemfile.lock
RUN bash -l -c "cd /app && bundle install -j4"

ADD . /app

WORKDIR /app
EXPOSE 8080

ENTRYPOINT ["chruby-exec", "ruby", "--"]
CMD ["bundle exec puma -t ${PUMA_MIN_THREADS:-8}:${PUMA_MAX_THREADS:-12} -w ${PUMA_WORKERS:-1} -p 8080 -e ${RACK_ENV:-production} --preload"]
