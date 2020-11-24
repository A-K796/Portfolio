class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
    @movie = Movie.new
    @movies = @user.movies.page(params[:page]).per(4).reverse_order
    @comment = @user.comments.page(params[:page]).per(4).reverse_order
    @all = Movie.all
  end

  private

  def user_params
    params.require(:user).permit(:name)
  end
end
