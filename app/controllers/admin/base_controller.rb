# app/controllers/admin/base_controller.rb
class Admin::BaseController < ApplicationController
  before_action :authenticate_user!  # Assure-toi que l'utilisateur est connecté
  before_action :check_admin         # Vérifie que l'utilisateur est un admin

  private

  def check_admin
    redirect_to new_post_path, alert: "Accès non autorisé" unless current_user.admin?
  end
end
