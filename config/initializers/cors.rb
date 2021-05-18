Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '*'

    resource '/api/*',
             headers: :any,
             methods: %i[get post put options patch delete options head],
             expose: %w[access-token expiry token-type uid client]
  end
end
