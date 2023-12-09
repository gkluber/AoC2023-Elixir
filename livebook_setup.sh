mix do local.rebar --force, local.hex --force
mix escript.install hex livebook

# Start the Livebook server
livebook server

# See all the configuration options
livebook server --help