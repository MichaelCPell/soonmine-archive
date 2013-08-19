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
        token_expiration: date_or_nil(auth_hash['credentials'][:expires_at]),
        refresh_token: auth_hash['credentials'][:refresh_token])
  end



  private

  def self.date_or_nil(date)
    DateTime.strptime(date.to_s,"%s") rescue nil
  end
end