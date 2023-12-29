require_relative 'jwt_authentication_middleware.rb'

class ProtectedsRoutes
    def initialize(app)
      @app = app
    end
  
    def call(env)
        request_path = env['REQUEST_PATH']
        if request_path.match(/\/api\/wallet\/?/)
            jwt = JwtAuthenticationMiddleware.new(@app) 
            return jwt.call(env)
        elsif request_path.match(/\/api\/debit\/?/)
            jwt = JwtAuthenticationMiddleware.new(@app) 
            return jwt.call(env)
        elsif request_path.match(/\/api\/credit\/?/)
            jwt = JwtAuthenticationMiddleware.new(@app) 
            return jwt.call(env)
        end
        @app.call(env)
    end
end