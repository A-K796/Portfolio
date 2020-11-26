class CommentsController < ApplicationController
  before_action :authenticate_user!
  def create
    @movie = Movie.find(params[:movie_id])
    @comment = current_user.comments.new(comment_params)
    @comment.movie_id = @movie.id
    if @comment.save
      redirect_to movie_path(movie), notice: "コメント投稿しました"
    else
      @comments = @movie.comments
      @genre = @movie.genre
      render template: 'movies/show'
    end
  end

  def destroy
    Comment.find_by(id: params[:id], movie_id: params[:movie_id]).destroy
		redirect_to request.referer, notice: "コメント削除しました"
  end

  private
  def comment_params
    params.require(:comment).permit(:title, :body)
  end
end
