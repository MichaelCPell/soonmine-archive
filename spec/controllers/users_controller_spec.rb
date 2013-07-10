require "spec_helper"

describe UsersController do 
  describe "GET show" do 
    let(:user) {FactoryGirl.create(:user)}

    it "finds User based on params[:id]" do 
      User.should_receive(:find).
        with(user.id.to_s).
        and_return(user)

      get :show, id: user.id
    end

    it "sends a message to instance of User to return 'Primary' list" do
      get :show, id: user.id
      assigns(:list).title.should eq("Primary")
    end
  end 

  describe "GET index" do 
    before do 
      3.times do
        FactoryGirl.create(:user)
      end
    end

    let(:users) {User.all}

    fit "without params, it retrieves all users" do 
      User.should_receive(:all)
      get :index
    end
  end
end