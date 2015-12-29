class BooksController < ApplicationController
  before_filter :authenticate, :only => [:create, :destroy]
  before_filter :authorized_user, :only => :destroy

  def create
    @book  = current_user.books.build(book_params)
    if @book.save
      flash[:success] = "Livre créé!"
      redirect_to root_path
    else
      @feed_items = []
      render 'pages/home'
    end
  end

  def destroy
    @book.destroy
    redirect_back_or root_path
  end

  private

  def authorized_user
    @book = Book.find(params[:id])
    redirect_to root_path unless current_user?(@book.user)
  end
  def book_params
    params.require(:book).permit(:titre, :auteur, :borrowed_by)
  end
end