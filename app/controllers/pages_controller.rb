class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:landing, :inscription, :contact, :confidentialite, :contact, :cgu, :legal, :cgv]

  def landing
  end

  def cgv
  end

  def legal
  end

  def account
    @user = current_user.reload
  end

  def quartz_agency
  end

  def contact
  end

  def cgu
  end

  def confidentialite
  end

  def inscription
  end

  def update_account
    @user = current_user
    if @user.update(user_params)
      logger.info "Mise à jour réussie: #{@user}"
      redirect_to account_path, notice: 'Vos informations ont été mises à jour.'
      puts user_params
    else
      logger.info "Échec de la mise à jour: #{@user.errors.full_messages}"
      render :account
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :company, :information, :instagram)
  end

end
