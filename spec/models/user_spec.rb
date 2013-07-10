require "spec_helper"

describe User do
  
  describe "validations" do
    it "is valid with valid attributes" do 
      auth_hash = { :email=>"michaelcpell@example.com",  
                    :firstname=>"Michael", 
                    :lastname=>"Pell",
                    password: "password"}

      @user = User.create(auth_hash)

      @user.should be_valid
    end
  end

  describe "self.create_with_omniauth" do
    it "creates a user from the omniauth hash" do 
      auth_hash = {:info =>
                    {
                    :email=>"michaelcpell@example.com", 
                    :name=>"Michael Chase Pell", 
                    :first_name=>"Michael", 
                    :last_name=>"Pell"}}

      @user = User.create_with_omniauth(auth_hash)

      @user.should be_valid

    end
  end

  describe "#fullname" do 
    it "concatenates firstname and lastname" do 
      auth_hash = { :email=>"michaelcpell@example.com",  
                    :firstname=>"Michael", 
                    :lastname=>"Pell",
                    password: "password"}

      @user = User.create(auth_hash)

      @user.fullname.should eq("Michael Pell")
    end
  end
end