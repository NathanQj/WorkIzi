class BooksController < ApplicationController
  before_filter :authenticate, :only => [:create, :destroy]
  before_filter :set_book, :only => [:show, :edit, :update, :destroy]


  def book_params
    params.require(:book).permit(:titre, :auteur, :borrowed_by)
  end

  def show
    @titre = @book.nom
  end

  def new
    @book = Book.new
    @title = "Ajouter un livre"
  end

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

  def edit
    @title = "Editer un livre"
  end

  def update
    if @book.update_attributes(book_params)
      flash[:success] = "Livre édité"
      redirect_to root_path
    else
      render 'edit'
    end
  end

  def destroy
    @book.destroy
    redirect_back_or root_path
  end

  private

  def logged_in_user
    unless logged_in?
      flash[:danger] = "Connectez-vous."
      redirect_to login_url
    end
  end


  def set_book
    @book = Book.find(params[:id])
  end

end