class Users::RegistrationsController < Devise::RegistrationsController
  def new_from_email
    build_resource({})
    respond_with self.resource
  end
end