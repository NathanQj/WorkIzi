class UsersController < ApplicationController


  def show
    @user = User.find(params[:id])
    @titre = @user.nom
  end

  def new
    @user = User.new
    @title = "S'inscrire"
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Vous êtes isncrit!"
      redirect_to @user
    else
      @titre = "Inscription"
      render 'new'
    end
  end

  def user_params
    params.require(:user).permit(:nom, :email, :password, :password_confirmation)
  end


end