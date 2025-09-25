import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :steef_min, SteefMinWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "uhI1uxGGk8UHz2xzZT8/HSHJrHkWCm+CcqnhS2cmLwAKDTt/ZZaG1It97qIuh7i7",
  server: false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
