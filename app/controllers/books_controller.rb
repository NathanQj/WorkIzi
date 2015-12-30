class BooksController < ApplicationController
  before_filter :authenticate, :only => [:create, :destroy]
  before_filter :authorized_user, :only => :destroy
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user,   only: [:edit, :update]

  def book_params
    params.require(:book).permit(:titre, :auteur, :borrowed_by)
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
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update_attributes(book_params)
      flash[:success] = "Livre édité"
      redirect_to @user
    else
      render 'edit'
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

  def logged_in_user
    unless logged_in?
      flash[:danger] = "Connectez-vous."
      redirect_to login_url
    end
  end

  def correct_user
    @user = User.find(params[:id])
    @book = Book.find(params[:user_id])
    redirect_to(root_url) unless @user == @book
  end


end