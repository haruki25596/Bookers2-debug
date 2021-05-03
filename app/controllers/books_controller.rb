class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_book_user, only: [:edit, :update, :destroy]


  def show
    @new_book = Book.new
    @book = Book.find(params[:id])
    @user = @book.user
    @book_comment = BookComment.new
  end

  def index
    @books = Book.all
    @user = current_user
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
  end



  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
     if @book.destroy
     flash[:notice] = "Book was successfully destroyed."
     redirect_to books_path
     else
     @books = Book.all
     render :index
     end
  end


  private

  def ensure_correct_book_user
    @book = Book.find(params[:id])
    unless @book.user.id == current_user.id
    # if @book.user.id != current_user.id 同じ意味
    redirect_to books_path
    end
  end

  def book_params
    params.require(:book).permit(:title, :body)
  end

end
