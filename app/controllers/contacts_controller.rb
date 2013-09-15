class ContactsController < ApplicationController

  def create
    if params[:source] == "manual"
      valid_contacts = true
      
      params[:contact].each do |data|
        contact = Contact.new(firstname: data[:firstname], 
                       lastname: data[:lastname], 
                       email: data[:email],
                       user_id: current_user.id)
        if contact.save == false
          valid_contacts = false
        end
      end

      if valid_contacts
        flash[:notice] = "Successfully Added Contacts!"
        redirect_to new_reminder_path
      else
        flash[:notice] = "Add least one of your contacts failed to save because of a blank email address."
        redirect_to new_reminder_path
      end


    else
      contacts_array = params[:contact]
      if contacts_array
        
        contacts_array.each do |x|
          split_contact = x.split(",")
          firstname = split_contact[0]
          email = split_contact[1]
          Contact.create(firstname: firstname, email: email, user_id: current_user.id)
        end
      end
      
      flash[:notice] = "Successfully Added Contacts!"
      redirect_to new_reminder_path
    end
  end

  def new
  end

  def add_from_google
    @user = current_user

    @results = @user.fetch_google_contacts
  end
end