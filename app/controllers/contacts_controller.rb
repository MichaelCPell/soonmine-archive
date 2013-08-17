class ContactsController < ApplicationController

  def create
    if params[:source] == "manual"

      params[:contact].each do |data|
        Contact.create(firstname: data[:firstname], email: data[:lastname], user_id: current_user.id)
      end

    else
      contacts_array = params[:contact]
      
      contacts_array.each do |x|
        split_contact = x.split(",")
        firstname = split_contact[0]
        email = split_contact[1]
        Contact.create(firstname: firstname, email: email, user_id: current_user.id)
      end
    end

    redirect_to current_user
  end

  def new
  end

  def add_from_google
    @user = current_user

    @results = @user.fetch_google_contacts
  end
end