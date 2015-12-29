class Book < ActiveRecord::Base

  def book_params
    params.require(:book).permit(:titre, :auteur, :borrowed_by)
  end

  belongs_to :user


  validates :titre, :presence => true
  validates :auteur, :presence => true
  validates :user_id, :presence => true

end
