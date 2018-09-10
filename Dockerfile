FROM elixir:1.7.3
MAINTAINER Jared Denisov

ARG MIX_ENV=dev
ENV MIX_ENV ${MIX_ENV}

RUN apt-get update && apt-get install -y \
 postgresql-client \
 inotify-tools \
 gcc \
 g++ \
 make

ENV DEBIAN_FRONTEND=noninteractive

# Install hex
RUN mix local.hex --force

# Install rebar
RUN mix local.rebar --force

# Install the Phoenix framework itself
RUN mix archive.install --force https://github.com/phoenixframework/archives/raw/master/phoenix_new.ez
RUN mix archive.install hex sobelow

RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -
RUN apt-get install -y -q nodejs
RUN npm i -g yarn

# Set /app as workdir
WORKDIR /app
RUN mkdir -p deps
ADD . /app

RUN mix do deps.get, compile
EXPOSE 4000
CMD ["mix", "do", "ecto.migrate,", "phoenix.server"]
