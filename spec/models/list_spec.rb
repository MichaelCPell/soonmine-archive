require "spec_helper"

describe List do 

  describe "validations" do 
    it "should be valid with a user_id" do
      List.new(user_id: 1).should be_valid 
    end

    it "should have a default title of 'Primary'" do
      List.new(user_id: 1).title.should eq("Primary")   
    end

    # it "is created after a user is created" do 
    #   @user = FactoryGirl.create(:user)
    #   @user.lists.first.should be_valid
    # end
  end
end