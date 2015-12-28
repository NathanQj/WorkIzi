class UsersController < ApplicationController


  def show
    @user = User.find(params[:id])
    @titre = @user.nom
  end

  def new
    @title = "S'inscrire"
  end

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end


end