class WalletController < ApplicationController
    include ActionView::Helpers::NumberHelper

    def profile_view(id_user = 0)
        id = id_user != 0 ? id : params[:id]

        user = User.find(id)
        wallet = Wallet.where(idusers: user.id).first
        start_date = Date.today.beginning_of_month
        end_date = Date.today.end_of_month

        amount_database = Transaction.where(idwallet: wallet.id, date: start_date..end_date, type_transaction: 'debito').sum(:amount)

        @balance = number_to_currency(wallet.balance, unit: "R$", separator: ",", delimiter: ".", format: "%u %n")
        @amount = number_to_currency(amount_database, unit: "R$", separator: ",", delimiter: ".", format: "%u %n")
        @user = user
        @wallet = wallet
        @transactions = Transaction.where(idwallet: wallet.id).order(id: :desc).limit(10)


        render 'profile_page'
    end

    def make_transaction
        user_id = params[:userid]
        type = params.require(:type)
        user = User.find(user_id)
        
        if user
            wallet = Wallet.where(idusers: user.id).first
            date = Date.today
            created_at = date.strftime('%Y-%m-%d')
            
            if type == "credit"
                amount = params.require(:valor_creditar)
                amount_formated = self.format_amount(amount)
                # register transaction
                transaction = Transaction.new(
                    date: created_at,
                    type_transaction: "credito",
                    amount: amount_formated,
                    idwallet: wallet.id
                )
                
                transaction.save
                new_balance = wallet.balance + amount_formated

                wallet = Wallet.find(wallet.id)
                wallet.update(
                    balance: new_balance
                )

            else type ==  "debito"
                amount = params.require(:valor_debitar)
                amount_formated = self.format_amount(amount)
                # register transaction
                
                new_balance = wallet.balance - amount_formated
                if new_balance > 0
                    wallet = Wallet.find(wallet.id)
                    wallet.update(
                        balance: new_balance
                    )

                    transaction = Transaction.new(
                        date: created_at,
                        type_transaction: "debito",
                        amount: amount_formated.to_d,
                        idwallet: wallet.id
                    )
                
                    transaction.save
                end
            end
            self.profile_view(user_id)
        end
    end

    def format_amount(amount)
        # Remover caracteres não numéricos
        amount = amount.gsub(/[^\d,]/, '')

        # Substituir ',' por '.' apenas se houver parte decimal depois da vírgula
        amount = amount.sub(/,(\d+)/, '.\1')

        # Converter para um número de ponto flutuante
        amount = amount.to_f
        return amount
    end
end
