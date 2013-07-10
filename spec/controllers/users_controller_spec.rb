require "spec_helper"

describe UsersController do 
  describe "GET show" do 
    let(:user) do
      auth_hash = { :email=>"michaelcpell@example.com",  
                    :firstname=>"Michael", 
                    :lastname=>"Pell",
                    password: "password"}

      User.create(auth_hash)
    end

    it "finds User based on params[:id]" do 
      User.should_receive(:find).
        with(user.id.to_s).
        and_return(user)

      get :show, id: user.id
    end

    it "sends a message to instance of User to return 'Primary' list" do
      User.any_instance.should_receive(:lists)

      assigns(:list).title.should eq("Primary")

      get :show, id: user.id
    end
  end 
end