class UsersController < ApplicationController
  def update_token
    if current_user.update(token: params[:token])
      render json: { success: true }, status: :ok
    else
      render json: { success: false, error: "Unable to update token." }, status: :unprocessable_entity
    end
  end
end
