class SessionsController < ApplicationController

  def new
    @titre = "Se connecter"
  end

  def create
    user = User.authenticate(params[:session][:nom],
                             params[:session][:password])
    if user.nil?
      flash.now[:error] = "Combinaison Identifiant/Mot de passe invalide."
      @titre = "Se connecter"
      render 'new'
    else
      sign_in user
      redirect_back_or user
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end
end