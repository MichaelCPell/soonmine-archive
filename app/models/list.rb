class List < ActiveRecord::Base
  validates_presence_of :user_id, :title

  has_many :products
  belongs_to :user

end
