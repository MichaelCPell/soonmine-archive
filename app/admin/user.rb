ActiveAdmin.register User do

  before_filter do 
    User.class_eval do
      def to_param
        id.to_s
      end
    end
  end
  index do
    column :email
    column :firstname
    column :lastname
    column :current_sign_in_at
    column :last_sign_in_at
    column :sign_in_count
    default_actions
  end

  filter :email

  form do |f|
    f.inputs "Admin Details" do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

  controller do
    def permitted_params
      params.permit admin_user: [:email, :password, :password_confirmation]
    end
  end
end 