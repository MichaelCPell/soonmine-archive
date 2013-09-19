class ProductsController < ApplicationController

  def new
    if request.env["HTTP_USER_AGENT"].match(/firefox/i)
      @agent = "firefox"
    elsif request.env["HTTP_USER_AGENT"].match(/chrome/i)
      @agent = "chrome"
    else
      @agent = "other"
    end
    
    @product = Product.new
  end

	def create
    @user = current_user

		@product = Product.new(product_params)

    @product.list_id = current_user.primary_list.id

    if @product.save
      @list = @user.primary_list_of_products(params[:sort])
      render "users/show"
    else
      render :edit
    end
	end

  def destroy
    Product.find(params[:id]).delete

    redirect_to current_user
  end


	private

  def product_params
    params.require(:product).permit(:name, :price, :image_url, :state, :offsite_url, :intensity)
  end
end
