require "spec_helper.rb"

describe ProductsController, focused: true do 
  describe "POST create" do 
    it "should create a new product for the current user" do
      product_hash = {
        name: "Flux Capacitor",
        offsite_url: "www.example.com"
      }


      controller.stub(:current_user).and_return(FactoryGirl.create(:user)) 

      post :create, product: product_hash

      assigns(:product).should be_valid
    end
  end
end