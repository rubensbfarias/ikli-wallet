class WalletApiController < ApplicationController
    #include AuthenticationConcern
    skip_before_action :verify_authenticity_token, only: [:debit_wallet, :credit_wallet]

    def get_wallet_by_user
        user_id = params[:userid]
        if user_id && user_id.instance_of?(String) && !user_id.empty?
            begin
                user_id = Integer(user_id)
                wallet = Wallet.where(idusers: user_id).pluck(:balance).first
                if wallet
                    balance = sprintf("%.2f", wallet)
                    return render json: {
                        user_id: user_id.to_i,
                        balance: balance.to_f
                    }
                end

            rescue ArgumentError
                return render json: {
                    error: "ID do usuário inválido"
                }, status: :bad_request #400
            end
        end
        return render json: {
            error: "ID do usuário inválido"
        }, status: :bad_request #400

    end

    def get_wallet_by_date
        user_id = params[:user_id]
        date = params[:date]
        if user_id && date && !date.empty?
            id_wallet = Wallet.where(idusers: user_id).pluck(:id).first

            if id_wallet
                transactions = Transaction.where(idwallet: id_wallet).where('date >= ?', date)
                # amount = sprintf("%.2f", wallet)
                return render json: {
                    user_id: user_id.to_i,
                    transactions: transactions.as_json()
                }
            end
        else
            id_wallet = Wallet.where(idusers: user_id).pluck(:id).first

            if id_wallet
                transactions = Transaction.where(idwallet: id_wallet)
                # amount = sprintf("%.2f", wallet)
                return render json: {
                    user_id: user_id.to_i,
                    transactions: transactions.as_json()
                }
            end
        end
        return render json: {
            error: "ID do usuário inválido"
        }, status: :bad_request #400
    end

    def debit_wallet
        user_id = params[:userid]
        amount = params[:amount]
        if user_id && user_id.instance_of?(String)
            begin
                user_id = Integer(user_id)
                amount = amount.to_f
                datetime = DateTime.now
                wallet = Wallet.where(idusers: user_id).first

                if wallet
                    new_amount = wallet.balance - amount
                    if amount != 0
                        if new_amount >= 0
                            # Create Transaction
                            transaction = Transaction.new(
                                date: datetime,
                                type_transaction: "debito",
                                amount: new_amount,
                                idwallet: wallet.id
                            )

                            transaction.save
                            
                            wallet.update(
                                balance: new_amount
                            )

                            balance = sprintf("%.2f", new_amount)
                            amount = sprintf("%.2f", amount)
                            return render json: {
                                user_id: user_id.to_i,
                                new_balance: balance.to_f,
                                transaction: transaction.as_json(only: 
                                [
                                    :id, 
                                    :date, 
                                    :type_transaction, 
                                    :idwallet, 
                                ]).merge({ amount: amount.to_f }),
                                message: 'Valor debitado com sucesso'
                            }
                        else
                            return render json: {
                                error: "Saldo insuficiente para essa transação"
                            }, status: :bad_request #400
                        end
                    else
                        return render json: {
                            error: "Valor da transação inválido"
                        }, status: :bad_request #400
                    end
                end

            rescue ArgumentError
                return render json: {
                    error: "ID do usuário inválido"
                }, status: :bad_request #400
            end
        end
        return render json: {
            error: "ID do usuário inválido"
        }, status: :bad_request #400
    end

    def credit_wallet
        user_id = params[:userid]
        amount = params[:amount]
        if user_id && user_id.instance_of?(String)
            begin
                user_id = Integer(user_id)
                amount = amount.to_f
                datetime = DateTime.now
                wallet = Wallet.where(idusers: user_id).first

                if wallet
                    new_amount = wallet.balance + amount
                    if amount != 0
                        # Create Transaction
                        transaction = Transaction.new(
                            date: datetime,
                            type_transaction: "credito",
                            amount: new_amount,
                            idwallet: wallet.id
                        )

                        transaction.save
                        
                        wallet.update(
                            balance: new_amount
                        )

                        balance = sprintf("%.2f", new_amount)
                        amount = sprintf("%.2f", amount)
                        return render json: {
                            user_id: user_id.to_i,
                            new_balance: balance.to_f,
                            transaction: transaction.as_json(only: 
                            [
                                :id, 
                                :date, 
                                :type_transaction, 
                                :idwallet, 
                            ]).merge({ amount: amount.to_f }),
                            message: 'Valor creditado com sucesso'
                        }

                    else
                        return render json: {
                            error: "Valor da transação inválido"
                        }, status: :bad_request #400
                    end
                end
            
            rescue ArgumentError
                return render json: {
                    error: "ID do usuário inválido"
                }, status: :bad_request #400
            end
        end
        return render json: {
            error: "ID do usuário inválido"
        }, status: :bad_request #400
    end
end
