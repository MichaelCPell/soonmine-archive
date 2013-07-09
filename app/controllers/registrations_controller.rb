class RegistrationsController < Devise::RegistrationsController
  def create
    params.permit(:user)
    super
  end

  def new
    super
  end
end