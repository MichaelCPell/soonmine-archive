class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def passthru
    render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
  end

  def facebook
    auth = request.env['omniauth.auth']
    @authentication = Authentication.find_with_omniauth(auth)    

      if @authentication.nil?
        @authentication = Authentication.new_with_omniauth(auth)
        if user_signed_in?
          if @authentication.user == current_user
            redirect_to root_url, notice: "Already linked that account!"
          else
            @authentication.user = current_user
            @authentication.save
            redirect_to root_url, notice: "Successfully linked that account!"
          end
        else
          if @authentication.user.present?
            flash[:notice] = "We found your account and have logged you in!"
          else
            @authentication.user_id = User.create_with_omniauth(auth).id
            @authentication.save
            flash[:notice] = "We've successfully created your new account!"
          end
          sign_in_and_redirect(User.find(@authentication.user_id))  
        end
      else
        flash[:notice] = "Login Successful"
        sign_in_and_redirect(User.find(@authentication.user_id))  
      end
  end

end
