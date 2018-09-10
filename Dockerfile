FROM elixir:1.7.3
MAINTAINER Jared Denisov

ARG MIX_ENV=dev
ENV MIX_ENV ${MIX_ENV}

RUN apt-get update && apt-get install -y \
 postgresql-client \
 inotify-tools \
 clang \
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

# Set /app as workdir
WORKDIR /app
RUN mkdir -p deps
ADD . /app

RUN mix do deps.get
EXPOSE 4000
CMD ["mix", "do", "ecto.create", "ecto.migrate,", "phoenix.server"]
