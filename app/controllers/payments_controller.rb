class PaymentsController < ApplicationController


  def checkout
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

  def success
    @product = Product.find(params[:product_id])
    @product.mode == "payment" ? get_tokens(@product) : get_premium
  end

  def cancel
    @product = Product.find(params[:product_id])
  end

  private

  def get_premium
    begin
      stripe_session = Stripe::Checkout::Session.retrieve(session[:stripe_session_id])
      if stripe_session.payment_status == "paid"
        current_user.premium! unless current_user.admin?
        session.delete(:stripe_session_id)
      end
    rescue
      redirect_to new_post_path, notice: "Vous avez bien souscrit à l'offre premium."
    end
  end

  def get_tokens(product)
    begin
      stripe_session = Stripe::Checkout::Session.retrieve(session[:stripe_session_id])
      if stripe_session.payment_status == "paid"
        current_user.wallet.add_tokens(product.amount)
        session.delete(:stripe_session_id)
      end
    rescue
      redirect_to new_post_path, notice: "Vous avez bien crédité votre porte-monnaie."
    end
  end

end
