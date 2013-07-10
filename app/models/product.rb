class Product < ActiveRecord::Base
  validates_presence_of :list_id
  
end