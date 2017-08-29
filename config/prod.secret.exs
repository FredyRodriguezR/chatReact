use Mix.Config

# In this file, we keep production configuration that
# you'll likely want to automate and keep away from
# your version control system.
#
# You should document the content of this
# file or create a script for recreating it, since it's
# kept out of version control and might be hard to recover
# or recreate for your teammates (or yourself later on).
config :chatV6, ChatV6Web.Endpoint,
  secret_key_base: "AsQC+E8xNBslPBFqsNMwivZ7wBvWC+gMdS7YgJeY22r36aEuGt5Vp7XaD2EbhXrS"

# Configure your database
config :chatV6, ChatV6.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "chatv6_prod",
  pool_size: 15
