
class JwtAuthenticationMiddleware
    def initialize(app)
      @app = app
    end
  
    def call(env)
      token = env['HTTP_AUTHORIZATION']&.split(' ')&.last
  
      if token && valid_token?(token)
        decoded_token = JWT.decode(token, 'ikli-desafio-rubens', true, algorithm: 'HS256')
        env['current_user'] = decoded_token.first['user_id'] 
        @app.call(env)
      else
        [401, { 'Content-Type' => 'application/json' }, [{ error: 'Token inválido' }.to_json]]
      end
    end
  
    private
  
    def valid_token?(token)
      begin
        JWT.decode(token, 'ikli-desafio-rubens', true, algorithm: 'HS256')

        true
      rescue JWT::DecodeError
        false
      end
    end
  end
  