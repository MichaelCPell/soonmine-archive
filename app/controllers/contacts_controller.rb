class ContactsController < ApplicationController
  class ParsedContact
    attr_accessor :name, :email
  end

  def new
  end

  def add_from_google

    
    array_of_contacts = []

    @user = current_user
    # This enter code to make the http requrest
    authentication = current_user.authentications.where(provider: "google_oauth2").first
    access_token = authentication.access_token
    api_uri = URI("https://www.google.com/m8/feeds/contacts/default/full?access_token=#{access_token}")

    results = Net::HTTP.get(api_uri)

    parse = Nokogiri::XML.parse(results)

    entries = parse.remove_namespaces!.xpath("*/entry")

    entries.each do |entry|
      new_contact = ParsedContact.new
      new_contact.name = entry.at_xpath('title').text rescue "No Name"
      new_contact.name = "No Name Retrieved" if new_contact.name == ""
      new_contact.email = entry.at_xpath('email/@address').value rescue "No Email"
      new_contact.email = "No Email Retrieved" if new_contact.email == ""
      array_of_contacts << new_contact
    end

    @results = array_of_contacts
  end
end