class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :omniauthable

  has_many :authentications
  has_many :contacts
  has_many :lists

  after_create {lists.create(title: "Primary")}


  def self.create_with_omniauth(auth_hash)
    info = auth_hash[:info]

    create( firstname: info[:first_name], 
            lastname: info[:last_name],
            email: info[:email], 
            image_url: info[:image])
  end

  def fullname
    firstname.blank? ? email : "#{firstname} #{lastname}"
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
    else
      list
    end
  end

  def fetch_google_contacts
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