require "spec_helper"

describe UsersController do
  describe "POST create" do 
    it "creates a new user" do 
      User.should_receive(:new).with(firstname: "SpecUser")
      post :create, :message
    end
    it "saves the user"
  end
end