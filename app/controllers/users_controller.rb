class UsersController < ApplicationController
   before_filter :check_for_email, if: :current_user, :except => [:purgatory]
  
  def index
  end

  def purgatory
  end
end