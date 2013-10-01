class List < ActiveRecord::Base
  validates_presence_of :user_id, :title
  before_save :default_values
  
  has_many :products
  belongs_to :user


  def default_values
    self.privacy ||= 'public'
  end

end
