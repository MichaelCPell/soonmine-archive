class UsersController < ApplicationController
  before_filter :check_for_email, if: :current_user, :except => [:purgatory]
  
  def show
    @user = User.find(params[:id])

    @list = @user.primary_list
  end

  def index
  end

  def purgatory
  end
end