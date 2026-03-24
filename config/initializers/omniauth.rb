Rails.application.config.middleware.use OmniAuth::Builder do
  if (google_creds = Rails.application.credentials.google)
    provider :google_oauth2, google_creds.client_id,
              google_creds.client_secret,
              {
                scope: 'email,profile',
                prompt: 'select_account',
                image_aspect_ratio: 'square',
                image_size: 50
              }
  end
end
OmniAuth.config.allowed_request_methods = %i[get]