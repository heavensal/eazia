class Admin::UsersController < Admin::BaseController

  def index
    @users = User.order(first_name: :asc)
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.includes(:gpt_creation).order(created_at: :desc).with_attached_photos
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update!(user_params)
    redirect_to admin_users_path, notice: "L'utilisateur #{@user.first_name} #{@user.last_name} a bien été modifié"
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path, notice: "Utilisateur supprimé"
  end

  ############################################################
  # ACTIONS TO INCREASE WALLETS
  ####
  def increase_wallets_10
    User.where(status: "freemium").each do |user|
      user.add_gold(10)
    end
    redirect_to admin_users_path, notice: "Les utilisateurs Freemium ont reçu 10 crédits"
  end

  def increase_wallets_30
    User.where(status: "beginner").each do |user|
      user.add_gold(30)
    end
    redirect_to admin_users_path, notice: "Les utilisateurs Beginner ont reçu 30 crédits"
  end

  def increase_wallets_100
    User.where(status: "premium").each do |user|
      user.add_gold(100)
    end
    redirect_to admin_users_path, notice: "Les utilisateurs Premium ont reçu 100 crédits"
  end
  ####
  ############################################################

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :wallet, :status)
  end
end
