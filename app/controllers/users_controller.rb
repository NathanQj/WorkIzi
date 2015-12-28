class UsersController < ApplicationController
  before_filter :authenticate, :only => [:index, :edit, :update]
  before_filter :correct_user, :only => [:edit, :update]


  def index
    @titre = "Tous les utilisateurs"
    @users = User.paginate(:page => params[:page])
  end


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
      sign_in @user
      flash[:success] = "Bienvenue dans l'Application Exemple !"
      redirect_to @user
    else
      @titre = "Sign up"
      render 'new'
    end
  end

  def user_params
    params.require(:user).permit(:nom, :email, :password, :password_confirmation)
  end

  def edit
    @titre = "Édition profil"
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profil actualisé."
      redirect_to @user
    else
      @titre = "Édition profil"
      render 'edit'
    end
  end

  private

  def authenticate
    deny_access unless signed_in?
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end

end