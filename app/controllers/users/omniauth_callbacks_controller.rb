class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def passthru
    render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
  end

  def twitter
    general_omniauth_login_strategy
  end

  def facebook
    general_omniauth_login_strategy
  end

  def google_oauth2
    general_omniauth_login_strategy
  end

  def general_omniauth_login_strategy
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

          user = User.find(@authentication.user_id)

          if user.sign_in_count == 0
            sign_in user
            redirect_to after_sign_up_path_for user
          else
            sign_in_and_redirect(user)  
          end
        end
      else
        flash[:notice] = "Login Successful"
        user = User.find(@authentication.user_id)

        if user.sign_in_count == 0
          sign_in user
          redirect_to after_sign_up_path_for user
        else
          sign_in_and_redirect(user)  
        end
      end
  end

  protected

  def after_sign_up_path_for(resource)
    confirmation_path
  end



end
