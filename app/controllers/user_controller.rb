class UserController < ApplicationController
    def index
        @usuarios = User.all
    end

    def create_user
        name = params.require(:name)
        email = params.require(:email)
        password = params.require(:password) 

        if !User.where(email:email).exists?
            date = Date.today
            created_at = date.strftime('%Y-%m-%d')
            user = User.new(
                name:name, 
                email:email, 
                password:password,
                created_at:created_at, 
                updated_at:created_at
            )

            if user.save
                session[:success] = "Usuário #{name} criado com sucesso!"
            end
        else
            session[:success] = "Usuário com o email #{email} já existe"
        end
    end

    def create_user_view
        render 'create_user'
    end
end
