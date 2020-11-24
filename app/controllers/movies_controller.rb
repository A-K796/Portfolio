class MoviesController < ApplicationController
  before_action :authenticate_user!

  def index
    @movies = Movie.page(params[:page]).per(5).reverse_order
  end

  def show
    @movie = Movie.find(params[:id])
    @genre = @movie.genre
    @comments = @movie.comments
    @comment = Comment.new
  end

  def create
    @movie = Movie.new(movie_params)
    @movie.save
    redirect_to movies_path, notice: "新規投稿しました"
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
			redirect_to movie_path(@movie.id), notice: "編集しました"
		else
			render "edit"
		end
  end

  def destroy
    @movie = Movie.find(params[:id])
		@movie.destroy
		redirect_to request.referer, notice: "削除しました"
  end

  private

  def movie_params
    params[:movie][:user_id] = current_user.id
    params.require(:movie).permit(:title, :body, :user_id, :genre_id, :image)
  end
end
