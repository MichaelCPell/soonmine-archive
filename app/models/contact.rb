class Contact < ActiveRecord::Base
  validates_presence_of :email, allow_blank: false
end
