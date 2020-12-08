# frozen_string_literal: true

Dotenv.load(".env.#{APP_ENV}")

APP_CONF =
  ENV.keys.select { |key| key.start_with?('SHOP') }.each_with_object({}) do |(key, _), config|
    _, group_name, var_name = key.split('_', 3).map(&:downcase).map(&:to_sym)
    config[group_name] ||= {}
    config[group_name][var_name] = ENV[key]
    config
  end.freeze

DB_CONF = {
  adapter: 'postgresql',
  encoding: 'unicode',
  username: 'ruby',
  password: 'ruby',
  host: 'localhost',
  port: '5432',
  database: "shop_sinatra",
  max_connections: APP_CONF.dig(:puma, :max_threads) || 10
}.merge(APP_CONF[:db] || {}).freeze
