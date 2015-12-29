class PagesController < ApplicationController
  def home
    @titre = "Home"
    if signed_in?
      @book = Book.new
      @feed_items = current_user.feed.paginate(:page => params[:page])
    end
  end

  def library
    @titre = "Bibliothèque"
  end
end