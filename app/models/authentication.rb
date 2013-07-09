class Authentication < ActiveRecord::Base

  validates_presence_of :uid, :user_id, :provider
  belongs_to :user


  def self.find_with_omniauth(auth_hash)
    find_by_provider_and_uid(auth_hash['provider'], auth_hash['uid'])
  end

  def self.new_with_omniauth(auth_hash)
    new(uid: auth_hash['uid'], 
           provider: auth_hash['provider'],
           access_token: auth_hash['credentials'][:token],
           token_expiration: DateTime.strptime(auth_hash['credentials'][:expires_at].to_s,"%s"))
  end

end