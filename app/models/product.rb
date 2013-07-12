class Product < ActiveRecord::Base
  validates_presence_of :list_id, :name, :offsite_url
  
end