require 'spec_helper'

describe Authentication do
  describe "validations" do 
    it "is valid with uid, user_id, and provider" do
      @authentication = Authentication.new({user_id: 1, uid: "123abc", provider: "facebook"})

      @authentication.should be_valid
    end
  end


  describe "self.find_with_omniauth" do 
    it "will return the appropriate record based on auth_hash" do
      auth_hash = {"provider" => "facebook", "uid" => "abc123"}
      Authentication.create(provider: "facebook", uid: "abc123", user_id: 1)
      @authentication = Authentication.find_with_omniauth(auth_hash)

      @authentication.user_id.should  equal(1)
    end
  end

  describe "self.new_with_omniauth" do 
    it "will create a new record if none is found" do
      auth_hash = {"provider" => "facebook", "uid" => "abc123", 
        "credentials" => {token: "faketoken", expires_at: 1378581723}} 
      @authentication = Authentication.new_with_omniauth(auth_hash)

      @authentication.provider.should eq("facebook")

    end
  end



end