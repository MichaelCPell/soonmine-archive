class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :omniauthable

  has_many :authentications

  # Setup accessible (or protected) attributes for your model

  def self.create_with_omniauth(auth_hash)
    info = auth_hash[:info]

    create( firstname: info[:first_name], 
            lastname: info[:last_name],
            email: info[:email], 
            image_url: info[:image])
  end

  def fullname
    "#{firstname} #{lastname}"
  end


  def auth_with_omniauth?
    authentications.any?
  end

end