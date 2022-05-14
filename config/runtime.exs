import Config

# config/runtime.exs is executed for all environments, including
# during releases. It is executed after compilation and before the
# system starts, so it is typically used to load production configuration
# and secrets from environment variables or elsewhere. Do not define
# any compile-time configuration in here, as it won't be applied.
# The block below contains prod specific runtime configuration.

# Start the phoenix server if environment is set and running in a release
if System.get_env("PHX_SERVER") && System.get_env("RELEASE_NAME") do
  config :food_elxpro, FoodElxproWeb.Endpoint, server: true
end

if config_env() == :prod do
  config :waffle,
    storage: Waffle.Storage.Google.CloudStorage,
    bucket: System.get_env("GCP_BUCKET")

  config :goth,
    json:
      "{\n  \"type\": \"service_account\",\n  \"project_id\": \"tactile-welder-350211\",\n  \"private_key_id\": \"be86c0a309fe88abfc5ea09345b0d2d00a27ee26\",\n  \"private_key\": \"-----BEGIN PRIVATE KEY-----\\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQDEZ+cdLsDeUIs+\\nqrZMDxbBh1oMTliD/OXhf49fRAzzwLRqWCyz6CRwHbkjxLFbjNk/nZk6lDuVmNSp\\nOKSgxG5KWZNVQ4HZLuzusq0w1UWfSqcVbsbUqnBgBo0L6HbBza1YRMn4lBFx4ZD0\\nQ+4TdYDUCxaMWl4o7imds9rPUNw5jns1QzJkMgFoR6X/cspu8nFqQF2IpEOAiw29\\nhaQ2r6Lq1FkVbUUVf3XbUl2fbgz+ogSeKkqhtjFxeV6aVHZHufgqYXCVNv/UHIxI\\nA0JKWVVYcd77rKcGVUqqnDBAC6Q+z6KB76MCKW3EnB7rRkcSzYwrKfn/BnM2biB3\\nqTK1yh5RAgMBAAECggEAA0B6+PItOYEWEvCjjjvr53Ee/gO2yr55j+gPrununmwD\\n1oS8UAQQraehyRukPNcVQcEdKF4L7/bgjoP7wXN/Jc1y92fj0tqOOnEpcr+4JHmV\\nCp/8XyYh00allQQqIb+xrZjTELY0WY5Zz1RzgnwPkaHARozPwkxGdZMTT0n45x3w\\nRERy6bmSDVxmVTuWWm6P4+5O2uqQtvxnk3QJ+qA/qJCQP2PaqH4EDDaQsU6mO+MG\\nuYoY35+c0rqngHTOmQj3Dr7JXl3ctUqZSHjqYM1e2Dq3S09nGjPlS7M1mUUbmpu3\\n1Lx6jrQixR4C1A+DwJQ+Pg59Nc+FRppDHytkm5ergQKBgQD0AMRR3BTHrpCzA+92\\nK8uYlbROSwhxwqFC8PNdBZ/vmXnY308VQPVJ61VXHmhiHleqIOVqGvA8nviFDjRq\\n5kVohlWrA7nWww1NQ2jCCDsRtsfxZ7GYKcApM40i9uF7m1gvFqEMnqieqeG1TdFv\\n5CPkq5Zi1Eo7y47ly/R7Yn0x/wKBgQDOEAmJdLJ36yb6fXZNAinm/4ZBOaubJ/Gu\\nWZ3deBXaawnWWz3KFhi26FZKpuzleTc03YEMN48zwUv9tB3dkA6eowKmqzxvW4SZ\\n6wirmzp8pe2kxz92+ebsBuWQ3Jno4Im/1mMAMK4aIhfv/VUkXziwOKBf7sQ9LeXb\\ncr9+FbkPrwKBgDyfsCdSkgsm0SbZNHbc3MH1eA330IpLPDvgl+alzh3+uOpsWT7D\\nm+4YvWRe1rqCJW/MqpNZTBUTvlV4uQdSXS5iKgjKbTLx1W078Vw8JUj6a+ULyXEv\\n9mGGQGvOgSlv6FISwkLbbLO3K7AbPI0bVtuq0juN2T/QDJoFuaGqT8bLAoGAU6lP\\nNe+bRfTDLpAhp8JpINA9wd2YPrZI+XCJF5HZzYQHym/g9ltiTWCnKEf9hm1gbKZB\\n7qPgEDM6lxa5yWrjhKTKPsDnGI8flx5FtuafKFx1z6DVs4hiqRFjwxzNoC8Jvklc\\niIc7KIEPFvDT0KCYc3OKKWjXY79uw1ojRR2stSECgYBJEhMj3GiFaiZkzKaA4T8M\\n53ZKef8Lklslcg6lIdAun/XpDoJ0/WfAtfLbLtm3VxbGxfHrlgivsfYW/0WUDtI/\\n66KQTbSulxljIJT5qaOJkW5Rm4azs6blM+9P4WqKmJGOO3EY/w8zAMnUzv/QaelJ\\nIBSgdngNXd0Ve+TC6lI3bw==\\n-----END PRIVATE KEY-----\\n\",\n  \"client_email\": \"bucket-elxpro-permissao@tactile-welder-350211.iam.gserviceaccount.com\",\n  \"client_id\": \"111002235522578010839\",\n  \"auth_uri\": \"https://accounts.google.com/o/oauth2/auth\",\n  \"token_uri\": \"https://oauth2.googleapis.com/token\",\n  \"auth_provider_x509_cert_url\": \"https://www.googleapis.com/oauth2/v1/certs\",\n  \"client_x509_cert_url\": \"https://www.googleapis.com/robot/v1/metadata/x509/bucket-elxpro-permissao%40tactile-welder-350211.iam.gserviceaccount.com\"\n}\n"

  database_url =
    System.get_env("DATABASE_URL") ||
      raise """
      environment variable DATABASE_URL is missing.
      For example: ecto://USER:PASS@HOST/DATABASE
      """

  maybe_ipv6 = if System.get_env("ECTO_IPV6"), do: [:inet6], else: []

  config :food_elxpro, FoodElxpro.Repo,
    # ssl: true,
    url: database_url,
    pool_size: String.to_integer(System.get_env("POOL_SIZE") || "2"),
    socket_options: maybe_ipv6

  # The secret key base is used to sign/encrypt cookies and other secrets.
  # A default value is used in config/dev.exs and config/test.exs but you
  # want to use a different value for prod and you most likely don't want
  # to check this value into version control, so we use an environment
  # variable instead.
  secret_key_base =
    System.get_env("SECRET_KEY_BASE") ||
      raise """
      environment variable SECRET_KEY_BASE is missing.
      You can generate one by calling: mix phx.gen.secret
      """

  host = System.get_env("PHX_HOST") || "example.com"
  port = String.to_integer(System.get_env("PORT") || "4000")

  config :food_elxpro, FoodElxproWeb.Endpoint,
    url: [host: host, port: 443],
    http: [
      # Enable IPv6 and bind on all interfaces.
      # Set it to  {0, 0, 0, 0, 0, 0, 0, 1} for local network only access.
      # See the documentation on https://hexdocs.pm/plug_cowboy/Plug.Cowboy.html
      # for details about using IPv6 vs IPv4 and loopback vs public addresses.
      ip: {0, 0, 0, 0, 0, 0, 0, 0},
      port: port
    ],
    secret_key_base: secret_key_base,
    check_origin: false

  # ## Using releases
  #
  # If you are doing OTP releases, you need to instruct Phoenix
  # to start each relevant endpoint:
  #
  #     config :food_elxpro, FoodElxproWeb.Endpoint, server: true
  #
  # Then you can assemble a release by calling `mix release`.
  # See `mix help release` for more information.

  # ## Configuring the mailer
  #
  # In production you need to configure the mailer to use a different adapter.
  # Also, you may need to configure the Swoosh API client of your choice if you
  # are not using SMTP. Here is an example of the configuration:
  #
  #     config :food_elxpro, FoodElxpro.Mailer,
  #       adapter: Swoosh.Adapters.Mailgun,
  #       api_key: System.get_env("MAILGUN_API_KEY"),
  #       domain: System.get_env("MAILGUN_DOMAIN")
  #
  # For this example you need include a HTTP client required by Swoosh API client.
  # Swoosh supports Hackney and Finch out of the box:
  #
  #     config :swoosh, :api_client, Swoosh.ApiClient.Hackney
  #
  # See https://hexdocs.pm/swoosh/Swoosh.html#module-installation for details.
end
