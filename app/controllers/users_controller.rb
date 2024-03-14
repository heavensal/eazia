class UsersController < ApplicationController
  def update_token
    @instagram_account = current_user.instagram_account
    if @instagram_account.update(token: params[:token])
      render json: { success: true }, status: :ok
    else
      render json: { success: false, error: "Unable to update token." }, status: :unprocessable_entity
    end
  end
end
