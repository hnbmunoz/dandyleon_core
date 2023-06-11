module Api
  module V2
    class TransactionsController < ApplicationController
      skip_before_action :verify_authenticity_token
      def index
        return head :not_acceptable, { msg: "Please Log in to your account" } if !Helpers.valid_token?(request.headers["token"])
        # all_transactions = Transaction.all.order(id: :desc)
        # results = ActiveRecord::Base.connection.exec_query("Select * from Transactions as t inner join Users as u")
        all_transactions = ActiveRecord::Base.connection.execute("Select *,t.status as delivered, t.id as transact_id from Transactions as t inner join Users as u on t.user_id = u.id")
        render(json: { data: all_transactions })
      end

      def show
        return head :not_acceptable, { msg: "Please Log in to your account" } if !Helpers.valid_token?(request.headers["token"])

       
      end

      def create
        return head :not_acceptable, { msg: "Please Log in to your account" } if !Helpers.valid_token?(request.headers["token"])
        status = Transaction::Generate.Receipt(request.headers["token"], transaction_params)    
        if status.is_a? Integer         
          response.set_header('msg', "Successfully Saved")                         
          render(json: Transaction.find(status))
        else          
          head :not_acceptable, { msg: status }
        end
  
        # new_transaction = Transaction.new(
        #   :products => transaction_params["products"],
        #   :user_id => User.find_by(:authorization_token => request.headers["token"]).id,
        #   :net_price => transaction_params["net_price"]
        # )
        # new_transaction.save     
        # binding.pry
        # print new_transaction.errors.full_messages
      end

      def delivered
        delivered_transaction = Transaction.find(params[:id])
        delivered_transaction.update(status: "Delivered")
        head :ok, { msg: "Record Updated" }
      end


      def modify
        return head :not_acceptable, { msg: "Please Log in to your account" } if !Helpers.valid_token?(request.headers["token"])
      end

      private

      def transaction_params
        params.require(:transaction).permit(:products, :net_price)
      end

    end
  end
end