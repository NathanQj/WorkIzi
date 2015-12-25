class PagesController < ApplicationController
  def home
    @titre = "Accueil"
  end

  def library
    @titre = "Bibliothèque"
  end
end
