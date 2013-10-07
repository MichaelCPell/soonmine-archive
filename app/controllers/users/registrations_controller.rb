class Users::RegistrationsController < Devise::RegistrationsController
	before_filter :configure_permitted_parameters, if: :devise_controller?

	def new_from_email
		build_resource({})
    render layout: "minimal"
	end

	def update
		@user = User.find(current_user.id)

    if primary_list_params = params[:user].delete("primary_list")
      @user.primary_list.update_attributes(primary_list_params)
    end

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

  def new
    build_resource({})
    render layout: "minimal"
  end

  def purgatory
    @user = current_user
  end

  def create
    build_resource(sign_up_params)

    if resource.save
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_navigational_format?
        sign_up(resource_name, resource)
        respond_with resource, :location => after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
        expire_session_data_after_sign_in!
        respond_with resource, :location => after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource

      render "devise/registrations/new_from_email"

    end
  end


	protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:firstname, :lastname, :username, :email, :password, 
      	:password_confirmation, :state, :town, :"birthday(1i)", :"birthday(2i)", :"birthday(3i)", :privacy)
    end
     devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(:first_name, :last_name, :username, :email, :password, 
      	:password_confirmation, :state, :town, :"birthday(1i)", :"birthday(2i)", :"birthday(3i)", :privacy, :current_password,
        :image_url, :street_address, :zipcode, :primary_list)
    end
  end

  def after_sign_up_path_for(resource)
    confirmation_path
  end

	private

		# check if we need password to update user data
		# ie if password or email was changed
		# extend this as needed
	def needs_password?(user, params)
		params[:user][:password].present? && user.authentications.blank?
	end

end