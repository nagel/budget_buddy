Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'https://blissful-hugle-75d10a.netlify.com'

    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head]
  end
end