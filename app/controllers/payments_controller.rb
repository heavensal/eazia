class PaymentsController < ApplicationController

  def index
    @products = Product.all
    @subscriptions = Subscription.all
  end

  def checkout
    if params[:product_id]
      set_product_checkout
    elsif params[:subscription_id]
      set_subscription_checkout
    end
  end

  def success
    if params[:product_id]
      @product = Product.find(params[:product_id])
      add_gold_from(@product)
    elsif params[:subscription_id]
      get_beginner
    end
  end

  def cancel
  end

  private

  def set_product_checkout
    @product = Product.find(params[:product_id])
    @session = Stripe::Checkout::Session.create(
      mode: @product.mode,
      payment_method_types: ['card'],
      billing_address_collection: 'required',
      # ui_mode: 'embedded',
      line_items: [{
        price: @product.stripe_price_id,
        # product: 'prod_PlDMkSAyZdhWe8',
        quantity: 1,
        }],
      # return_url: payments_success_url,
      success_url: product_payments_success_url,
      cancel_url: product_payments_cancel_url
      )
    session[:stripe_session_id] = @session.id
    redirect_to @session.url, allow_other_host: true
  end

  def set_subscription_checkout
    @subscription = Subscription.find(params[:subscription_id])
    @session = Stripe::Checkout::Session.create(
      mode: @subscription.mode,
      payment_method_types: ['card'],
      billing_address_collection: 'required',
      # ui_mode: 'embedded',
      line_items: [{
        price: @subscription.stripe_price_id,
        # product: 'prod_PlDMkSAyZdhWe8',
        quantity: 1,
        }],
      # return_url: payments_success_url,
      success_url: subscription_payments_success_url,
      cancel_url: subscription_payments_cancel_url
      )
    session[:stripe_session_id] = @session.id
    redirect_to @session.url, allow_other_host: true
  end

  def get_beginner
    begin
      stripe_session = Stripe::Checkout::Session.retrieve(session[:stripe_session_id])
      if stripe_session.payment_status == "paid"
        current_user.beginner! unless current_user.admin?
        current_user.add_gold(30)
        session.delete(:stripe_session_id)
      end
    rescue
      redirect_to new_post_path, notice: "Vous avez bien souscrit à l'offre Beginner."
    end
  end

  def add_gold_from(product)
    begin
      stripe_session = Stripe::Checkout::Session.retrieve(session[:stripe_session_id])
      if stripe_session.payment_status == "paid"
        current_user.add_gold(product.amount)
        session.delete(:stripe_session_id)
      end
    rescue
      redirect_to new_post_path, notice: "Vous avez bien crédité votre porte-monnaie."
    end
  end

end
