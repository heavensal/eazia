class Admin::UsersController < Admin::BaseController

  def index
    @users = User.order(first_name: :asc)
  end

  def show
    @user = User.find(params[:id])
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

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :wallet, :status)
  end
end
