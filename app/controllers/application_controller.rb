class ApplicationController < ActionController::Base

    config.middleware.insert_before 0, Rack::Corsdo

      allow do

        origins '*'

        resource '*', :headers=>:any, :methods=>[:get, :post, :options]

      end

    end


  # WITH SANDBOX KEY
  @@client = Plaid::Client.new(
    env: :sandbox,
    client_id: ENV["API_CLIENT_ID"],
    secret: ENV["API_SECRET"],
    public_key: ENV["API_PUBLIC_KEY"]
  )  

  #protect_from_forgery with: :null_session
  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }

  def current_user
    auth_headers = request.headers['Authorization']
    if auth_headers.present? && auth_headers[/(?<=\A(Bearer ))\S+\z/]
      token = auth_headers[/(?<=\A(Bearer ))\S+\z/]
      begin
        decoded_token = JWT.decode(
          token,
          Rails.application.credentials.fetch(:secret_key_base),
          true,
          { algorithm: 'HS256' }
        )
        User.find_by(id: decoded_token[0]["user_id"])
      rescue JWT::ExpiredSignature
        nil
      end
    end
  end

  helper_method :current_user

  def authenticate_user
    unless current_user
      render json: {}, status: :unauthorized
    end
  end


end
