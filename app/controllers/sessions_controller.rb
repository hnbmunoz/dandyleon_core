class SessionsController < ApplicationController 
  skip_before_action :verify_authenticity_token

  def sign_up
    begin
      status = Session::Process.Registration(sessions_params)
      
      if status == "Account Created"
        head :ok, { msg: status }
      else
        head :not_acceptable, { msg: status }
      end
    rescue => exception
      head :internal_server_error, { msg: "Problem in the server try again later" }
    end   
  end

  def sign_in  
    begin
      my_profile = Session::Process.Verification(sessions_params)
      if my_profile
        authorization_token = Helpers.generate_token
        response.set_header('msg', 'Login Complete')    
        render(json: my_profile)
      else
        head :not_acceptable, { msg: "Invalid UserName or Password" }
      end 
    rescue => exception
      head :internal_server_error, { msg: "Problem in the server try again later" }
    end    
  end

  def reset_password
  end

  def authorize
  end

  private
  def sessions_params
    params.permit(:username, :password, :email, :fname, :mname, :lname, :display_name, :user_type)
  end
end