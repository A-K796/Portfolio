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
    @movie = Movie.find(params[:id])
		if @movie.user != current_user
			redirect_to movies_path
		end
  end

  def update
    @movie = Movie.find(params[:id])
		@movie.update(movie_params)
		if @movie.save
			redirect_to movie_path(@movie.id)
		else
			render "edit"
		end
  end

  def destroy
    @movie = Movie.find(params[:id])
		@movie.destroy
		redirect_to request.referer
  end

  private

  def movie_params
    params[:movie][:user_id] = current_user.id
    params.require(:movie).permit(:title, :body, :user_id, :genre_id, :image)
  end
end
