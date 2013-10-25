class UsersController < ApplicationController
  before_filter :check_for_email, except: [:index, :show]
  
  def show
    @user = User.friendly.find(params[:id])

    if @user.primary_list.privacy == "private"
      redirect_to current_user if @user != current_user
    end

    @list = @user.primary_list_of_products(params[:sort])
  end

  def index
    if params[:search] && params[:search] != ""
      search = params[:search].gsub(/\s/,'')
      @users = User.where("CONCAT(firstname, lastname) ILIKE ?","%#{search}%").joins(:lists).where(lists: {privacy: "public"})
    else
      @users = []
    end
  end


end