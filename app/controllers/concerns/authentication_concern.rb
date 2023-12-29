
module AuthenticationConcern
    extend ActiveSupport::Concern
  
    included do
      before_action :authenticate_user
    end
  
    def authenticate_user
      if request.env['current_user'].nil?
        render json: { error: 'Token de autenticação ausente ou inválido' }, status: :unauthorized
      end
    end
  end
  