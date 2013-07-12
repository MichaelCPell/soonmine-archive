require "spec_helper"

describe User do
  let(:user) { FactoryGirl.create(:user) }

  describe "essentials" do

    it "is valid with valid attributes" do 
      user.should be_valid
    end

    it "creates a 'Primary' list after being created" do
      user.lists.find_by_title("Primary").should_not be_nil
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


  describe "#primary_list" do 
    it "returns the list titled 'Primary'" do
      user.primary_list.title.should eq("Primary") 
    end
  end
end