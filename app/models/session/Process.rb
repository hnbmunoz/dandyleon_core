class Session 
  class Process
    def self.Registration(information)    

      return "First name is required" if information['fname'] == "" or  information['fname'] == nil
      return "Email not in proper format" if !information['email'].match(/\S+@\S+\.\S+/)
      return "Email already exists" if User.find_by(email: information['email']) != nil
      return "Username already exists" if Account.find_by(username: information['username']) != nil      
      return "Increase Password Strength" if  !information['password'].match(/^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&*])(?=.{8,})/) 

      new_user = User.new(
        "fname": information['fname'],
        "mname": information['mname'],
        "lname": information['lname'],
        "email": information['email'],
        "display_name": information['display_name'],   
        "activation_token": Helpers.generate_token ,
        "status": "pending"
      )
         
      if new_user.save
        new_account = Account.new(
          "user_id": new_user.id,
          "username": information['username'],
          "password": information['password'],
          "user_level": information['user_type'],
        )        
        new_account.save
        
        return "Account Created" if (new_account.save)
        if !(new_account.save)
          User.find(new_user.id).destroy 
          return "Account creation failed try again"                   
        end

      else       
        return false
      end
    end

    def self.Verification(credentials)          
      find_account = Account.joins(:user).where(
        [
          "username = ? or email = ?",
          credentials["username"], credentials["username"]
        ]
      )     
      return false if find_account == nil || find_account.empty? 

      selected_account = find_account[0]     
      
      if selected_account[:password] ==  credentials[:password]
        
        logged_user = User.find(selected_account[:user_id]) 
        token = Helpers.generate_token
        logged_user.update(authorization_token: token)         
        return {          
          token: token,
          display: logged_user["display_name"] == "" ? logged_user["fname"] : logged_user["display_name"],
          is_admin: find_account[0][:user_level] == 1 ? true : false 
        }

      else
        return false      
      end
      
    end
    
  end
end