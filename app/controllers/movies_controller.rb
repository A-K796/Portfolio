class MoviesController < ApplicationController
  def index
    @movies = Movie.all
  end

  def show
    @movie = Movie.find(params[:id])
    @comments = @movie.comments
    @comment = Comment.new
  end

  def create
    @movie = Movie.new(movie_params)
    @movie.save
    redirect_to movies_path
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def movie_params
    params[:movie][:user_id] = current_user.id
    params.require(:movie).permit(:title, :body, :user_id, :genre_id, :image)
  end
end
