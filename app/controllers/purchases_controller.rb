class PurchasesController < ApplicationController
  before_action :authenticate_user!,except: [:index, :show]
  def index
    @all_purchases = current_user.purchases

  end
  def show
     # @current_purchase = current_user.purchases.last
     @latest_purchase = Purchase.find(params[:id]) # .find method only by id

  end
  def new
    @searched_product = Product.find(params[:id])
    @new_purchase = current_user.purchases.new
  end
  def create
    @user_id = current_user.id
    # @product_id = (params[:product][:product_id])
    @current_product = Product.find(params[:id])
    @current_product.add_purchase(@user_id)
    @current_purchase = current_user.purchases.last
    redirect_to purchase_path(@current_purchase.id)
    # render json: @current_purchase.id

  end

  def edit
    @searched_purchase = Purchase.find(params[:id])
  end

  def update
    @searched_purchase = Purchase.find(params[:id])
    @searched_purchase.update(purchase_params)
    redirect_to purchases_path
  end
  def destroy
    Purchase.find(params[:id]).delete
    redirect_to purchases_path
  end
  def purchase_params
    params.require(:purchase).permit(:name,:user_id, :product_id)
  end
end