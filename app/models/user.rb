class User < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :omniauthable, :validatable

  has_many :authentications, dependent: :destroy
  has_many :contacts
  has_many :lists
  
  after_create {lists.create(title: "Primary")}
  after_create {UserMailer.welcome_email(self).deliver}

  validates_presence_of :firstname, :lastname, :email

  


  def slug_candidates
    [ [:firstname, :lastname],
      [:firstname, :lastname, :id]
    ]
  end

  def self.create_with_omniauth(auth_hash)
    info = auth_hash[:info]
    password = User.generate_token('encrypted_password')


    case auth_hash[:provider]
    when "facebook"
      create( firstname: info[:first_name], 
            lastname: info[:last_name],
            email: info[:email], 
            image_url: info[:image][0..-12] + "height=300&width=300",
            password: password,
            password_confirmation: password)
    else
     create( firstname: info[:first_name], 
          lastname: info[:last_name],
          email: info[:email], 
          image_url: info[:image],
          password: password,
          password_confirmation: password)
    end
  end

  def avatar_url
    filepicker_url ? filepicker_url : profile_image_url
  end

  def fullname
    firstname.blank? ? "" : "#{firstname} #{lastname}"
  end

  def location

    if (self.town == "") || (self.town == nil)
      town = ""
    else
      town = self.town+", "
    end
    state = self.state ? self.state : ""
    location = town + state
  end

  def primary_list
    lists.find_by_title("Primary")
  end

  def primary_list_of_products(sort = nil)
    list = lists.find_by_title("Primary").products

    case sort
    when "date"
      list.order(:created_at)
    when "lowest"
      list.order("price ASC")
    when "highest"
      list.order("price DESC")
    when "want"
      list.where(intensity: 3)
    when "really"
      list.where(intensity: 2)
    when "need"
      list.where(intensity: 1)
    else
      list
    end
  end

  def refresh_google_token
    authentication = authentications.where(provider: "google_oauth2").first
    uri = "https://accounts.google.com/o/oauth2/token"
    refresh_token = authentication.refresh_token
    client_id = "249589806282.apps.googleusercontent.com"
    client_secret = "moNGTFhniRA-4iHWc-XiuMgX"
    grant_type = "refresh_token"


    result = HTTParty.post(uri,
                            body: { refresh_token: refresh_token,
                                    client_id: client_id,
                                    client_secret: client_secret,
                                    grant_type: grant_type})

    parse = JSON.parse(result.body)

    authentication.update_attribute(:access_token, parse["access_token"])
  end


  def fetch_google_contacts
    refresh_google_token
    array_of_contacts = []
    authentication = authentications.where(provider: "google_oauth2").first
    access_token = authentication.access_token
    api_uri = URI("https://www.google.com/m8/feeds/contacts/default/full?access_token=#{access_token}&max-results=9999999")

    results = Net::HTTP.get(api_uri)

    parse = Nokogiri::XML.parse(results)

    entries = parse.remove_namespaces!.xpath("*/entry")

    entries.each do |entry|
      new_contact = ParsedContact.new
      new_contact.name = entry.at_xpath('title').text rescue "No Name"
      new_contact.name = "No Name Retrieved" if new_contact.name == ""
      new_contact.email = entry.at_xpath('email/@address').value rescue "No Email"
      new_contact.email = "No Email Retrieved" if new_contact.email == ""
      array_of_contacts << new_contact if new_contact.email != "No Email"
    end

    array_of_contacts
  end


  #Helper Class
  class ParsedContact
    attr_accessor :name, :email
  end


end