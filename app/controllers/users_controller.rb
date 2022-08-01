class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @new_book = Book.new
    @books = @user.books
  end

  def index
    @user = User.find(current_user.id)
    @users = User.all
    @new_book = Book.new
  end

  def edit
    @user = User.find(params[:id])
    if current_user.id != @user.id
      redirect_to user_path(current_user.id)
    else
      @user = User.find(current_user.id)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id),notice: 'You have updated user successfully.'
    else
      render :edit
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def user_params
    params.require(:user).permit(:name,:profile_image, :introduction,)
  end

end
