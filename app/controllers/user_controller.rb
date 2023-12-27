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
               if !Wallet.where(idusers: user.id).exists?
                    Wallet.new(
                        idusers: user.id,
                        balance: 0
                    )
               end

               flash[:success] = "Usuário #{name} criado com sucesso!"
            end
        else
           flash[:success] = "Usuário com o email #{email} já existe"
        end

        redirect_to '/users'
    end

    def create_user_view
        render 'create_user'
    end

    def destroy_user
        id = params[:id]

        user = User.find(id)

        if user
            user.destroy
            flash[:success_delete] = "Usuário excluído com sucesso!"
        end

        redirect_to '/users'
    end

    def edit_user
        id = params[:id]
        @user = User.find(id)

        render "create_user"
    end

    def update_user
        id = params[:id]
        user = User.find(id)
      
        if user
          name = params[:name].presence || user.name
          email = params[:email].presence || user.email
          password = params[:password].presence || user.password
      
          date = Date.today
          updated_at = date.strftime('%Y-%m-%d')
      
          user.update(
            name: name,
            email: email,
            password: password,
            updated_at: updated_at
          )
        end

        redirect_to '/users'
    end
      
end
