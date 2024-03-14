class InstragramAccountsController < ApplicationController
  def update
    @instagram_account = current_user.instagram_account
    if @instagram_account.update(token: params[:token])
      instagram_business = FbApiService.new(current_user).instagram_account(@instagram_account.token)
      @instagram_account.update!(instagram_business: instagram_business)
      FbApiService.new(current_user).instagram_profile(@instagram_account)
      render json: { success: true }, status: :ok
    else
      render json: { success: false, error: "Impossible de mettre à jour le token." }, status: :unprocessable_entity
    end
  end
end
