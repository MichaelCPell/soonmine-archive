ActiveAdmin.register Product do
  index do
    column :name
    column :price
    column :intensity
    column :offsite_url
    default_actions
  end

  filter :email

  form do |f|
    f.inputs "Admin Details" do
      f.input :name
      f.input :price
      f.input :list_id
      f.input :intensity
      f.input :offsite_url
    end
    f.actions
  end

  controller do
    def permitted_params
      params.permit product: [:name, :price, :intensity, :offsite_url, :list_id]
    end
  end
end 