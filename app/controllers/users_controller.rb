class UsersController < ApplicationController
  def show
    @user = current_user
    @movie = Movie.new
    @movies = @user.movies
  end

  def edit
  end

  def update
  end

  private

  def user_params
    params.require(:user).permit(:name)
  end
end
