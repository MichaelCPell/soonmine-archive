class UsersController < ApplicationController
  before_filter :check_for_email
  
  def show
    @user = User.find(params[:id])
    @list = @user.primary_list_of_products(params[:sort])
  end

  def index
    if params[:search]
      search = params[:search].gsub(/\s/,'')
      @users = User.where("CONCAT(firstname, lastname) ILIKE ?","%#{search}%")
    else
      @users = User.all
    end
  end


end