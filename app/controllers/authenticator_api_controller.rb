class AuthenticatorApiController < ActionController::API
    def signin
        email = params[:email]
        password = params[:password]

        user = User.find_by(email: email)

        if user && BCrypt::Password.new(user.password_digest) == password
            jwt_token = self.generate_token(user.id)
            wallet = Wallet.find_by(idusers: user.id)
            balance = sprintf("%.2f", wallet.balance)

            render json: { 
                user: user.as_json(only: [:id, :email ]),
                balance: balance,
                token: jwt_token
            }
        else
            render json: { error: 'Credenciais inválidas' }, status: :unauthorized #401
        end

    end

    private
    def generate_token(user_id)
        # Configure a chave secreta para assinar o token. Guarde essa chave em um local seguro.
        secret_key = 'ikli-desafio-rubens'
    
        # Crie um token JWT
        payload = { user_id: user_id }
        token = JWT.encode(payload, secret_key, 'HS256')
    
        return token
    end
end
