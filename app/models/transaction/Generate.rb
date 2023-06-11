class Transaction
  class Generate    
    def self.Receipt(token, details)
      new_transaction = Transaction.new(
        :products => details["products"],
        :user_id => User.find_by(:authorization_token => token).id,
        :net_price => details["net_price"]
      )      

      # print new_transaction.errors
      return new_transaction.id if (new_transaction.save)   
    end    
  end
end
