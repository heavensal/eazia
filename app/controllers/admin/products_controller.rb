class Admin::ProductsController < Admin::BaseController
  before_action :set_product, only: %i[show edit update destroy]

  def index
    @products = Product.order(name: :asc)
  end

  def show
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.create!(product_params)
    redirect_to admin_products_path, notice: "Le produit a bien été créé"
  end

  def edit
  end

  def update
    @product.update!(product_params)
    redirect_to admin_products_path, notice: "Le produit a bien été modifié"
  end

  def destroy
    @product.destroy
    redirect_to admin_products_path, notice: "Produit supprimé"
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :price, :description, :mode, :stripe_price_id, :subscribe_type, :amount)
  end
end
