class Admin::SubscriptionsController < Admin::BaseController
  before_action :set_subscription, only: %i[show edit update destroy]

  def index
    @subscriptions = Subscription.order(name: :asc)
  end

  def show
  end

  def new
    @subscription = Subscription.new
  end

  def create
    @subscription = Subscription.create!(subscription_params)
    redirect_to admin_subscriptions_path, notice: "Le produit abonnement a bien été créé"
  end

  def edit
  end

  def update
    @subscription.update!(subscription_params)
    redirect_to admin_subscriptions_path, notice: "Le produit abonnement a bien été modifié"
  end

  def destroy
    @subscription.destroy
    redirect_to admin_subscriptions_path, notice: "Le produit Abonnement a bien été supprimé"
  end

  private

  def set_subscription
    @subscription = Subscription.find(params[:id])
  end

  def subscription_params
    params.require(:subscription).permit(:name, :price, :description, :mode, :stripe_price_id, :subscribe_type, :amount)
  end
end
