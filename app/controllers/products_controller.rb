class ProductsController < ApplicationController

  def new
    @product = Product.new
  end

	def create
    @user = current_user

		@product = Product.new(product_params)

    @product.list_id = current_user.primary_list.id

    if @product.save
      render "users/show"
    else
      render :edit
    end
	end


	private

  def product_params
    params.require(:product).permit(:name, :price, :image_url, :state, :offsite_url)
  end
end
