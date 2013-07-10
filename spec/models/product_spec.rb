require "spec_helper"

describe Product do
  describe "essentials" do 
    it "is valid with valid attributes" do 
      Product.new(list_id: 1).should be_valid
    end
  end
end