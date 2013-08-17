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
    "#{firstname} #{lastname}"
  end

  def primary_list
    lists.find_by_title("Primary")
  end

  def fetch_facebook_friends
    # identity = Identity.where(user_id: id, provider: "facebook").first

    # uri_string = "https://graph.facebook.com/#{identity.uid}/friends?access_token=#{identity.access_token}"

    # uri = URI(uri_string)

    # https = Net::HTTP.new(uri.host, uri.port)
    # https.use_ssl = true
    # https.ca_file = 'cacert.pem' if Rails.env == "development"
    # response_object = https.request_get(uri.path+"?"+uri.query)
    # response_body = response_object.body

    # parse = JSON.parse(response_body)
    # friends = parse["data"]

    authentication = Authentication.where(user_id: id, provider: "facebook").first

    uri_string = "https://graph.facebook.com/#{authentication.uid}/friends?access_token=#{authentication.access_token}"
    uri = URI(uri_string)
    results = Net::HTTP.get(uri)

    

  end


  def prefriended_facebook_friends_on_offline
    array_of_fb_uids = fetch_facebook_friends.map{|x|x["id"]}
    array_of_friend_ids = friends.map(&:id)
    array_of_friend_ids << 0

    array_of_exfriend_ids = exfriends.map(&:id)
    array_of_exfriend_ids << 0

    res = User.select("users.id, users.profile_image_url, users.name").joins(:identities)
    .where("identities.uid in (?)", array_of_fb_uids).where("users.id NOT IN (?)", array_of_friend_ids)
    .where("users.id NOT IN (?)", array_of_exfriend_ids)

  end

  def fetch_google_contacts
    array_of_contacts = []
    authentication = authentications.where(provider: "google_oauth2").first
    access_token = authentication.access_token
    api_uri = URI("https://www.google.com/m8/feeds/contacts/default/full?access_token=#{access_token}&max-results=100")

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