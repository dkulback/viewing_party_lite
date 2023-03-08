FROM ruby:2.7.7-alpine3.16

RUN apk add --no-cache \
    build-base \
    postgresql-dev \
    nodejs \
    yarn \
    postgresql-client

ENV APP_HOME /app

RUN mkdir $APP_HOME
WORKDIR $APP_HOME

COPY Gemfile Gemfile.lock $APP_HOME/
RUN bundle install --binstubs

COPY . $APP_HOME

# Configure Postgres
ENV POSTGRES_USER=party \
    POSTGRES_PASSWORD=party \
    POSTGRES_DB=viewing_party

RUN mkdir -p /var/run/postgresql && chown -R postgres /var/run/postgresql

USER postgres
RUN initdb -D /var/lib/postgresql/data
RUN pg_ctl start -D /var/lib/postgresql/data &&\
    psql --command "CREATE USER $POSTGRES_USER WITH SUPERUSER PASSWORD '$POSTGRES_PASSWORD';" &&\
    createdb -O $POSTGRES_USER $POSTGRES_DB &&\
    pg_ctl stop -D /var/lib/postgresql/data

USER root

# Start Rails server
CMD ["sh", "-c", "rails db:migrate && rails server -b 0.0.0.0"]
