class MoviesController < ApplicationController
  before_action :authenticate_user!

  def index
    @genres = Genre.all
    if params[:genre_id].present?
      @movies = Movie.where(genre_id: params[:genre_id]).page(params[:page]).per(5).reverse_order
    else
      @movies = Movie.page(params[:page]).per(5).reverse_order
    end
  end

  def show
    @movie = Movie.find(params[:id])
    @genre = @movie.genre
    @comments = @movie.comments
    @comment = Comment.new
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      redirect_to movies_path, notice: "新規投稿しました"
    else
      @user = current_user
      @movies = @user.movies.page(params[:page]).per(4).reverse_order
      @comment = @user.comments.page(params[:page]).per(4).reverse_order
      render template: "users/show"
    end
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

  def search
    @genres = Genre.all
    selection = params[:keyword]
    case selection
    when 'new'
      @movies = Movie.page(params[:page]).order(created_at: :DESC).per(5)
    when 'old'
      @movies = Movie.page(params[:page]).order(created_at: :ASC).per(5)
    when 'likes'
      @movies = Movie.page(params[:page]).left_joins(:likes).group(:id).order(Arel.sql('COUNT(likes.id) DESC')).per(5)
    when 'comment'
      @movies = Movie.page(params[:page]).left_joins(:comments).group(:id).order(Arel.sql('count(comments.id) DESC')).per(5)
    end
  end

  private
  def movie_params
    params[:movie][:user_id] = current_user.id
    params.require(:movie).permit(:title, :body, :user_id, :genre_id, :image)
  end
end
