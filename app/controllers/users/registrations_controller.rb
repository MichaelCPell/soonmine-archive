class Users::RegistrationsController < Devise::RegistrationsController
	before_filter :configure_permitted_parameters, if: :devise_controller?

	def new_from_email
		build_resource({})
		respond_with self.resource
	end

	def update
		@user = User.find(current_user.id)

		successfully_updated = if needs_password?(@user, params)
		@user.update_with_password(devise_parameter_sanitizer.for(:account_update))
		else
			# remove the virtual current_password attribute update_without_password
			# doesn't know how to ignore it
			params[:user].delete(:current_password)
			@user.update_without_password(devise_parameter_sanitizer.for(:account_update))
		end

		if successfully_updated
				set_flash_message :notice, :updated
				# Sign in the user bypassing validation in case his password changed
				sign_in @user, :bypass => true
				redirect_to @user
		else
				render "edit"
		end
	end



	protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:first_name, :last_name, :username, :email, :password, 
      	:password_confirmation, :state, :town, :"birthday(1i)", :"birthday(2i)", :"birthday(3i)", :privacy)
    end
    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(:first_name, :last_name, :username, :email, :password, 
      	:password_confirmation, :state, :town, :"birthday(1i)", :"birthday(2i)", :"birthday(3i)", :privacy, :current_password,
        :image_url)
    end
  end


	private

		# check if we need password to update user data
		# ie if password or email was changed
		# extend this as needed
	def needs_password?(user, params)
			user.email != params[:user][:email] ||
			params[:user][:password].present?
	end

end