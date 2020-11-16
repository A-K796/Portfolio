class CommentsController < ApplicationController
  def create
    movie = Movie.find(params[:movie_id])
    comment = current_user.comments.new(comment_params)
    comment.movie_id = movie.id
    comment.save
    redirect_to movie_path(movie)
  end

  def destroy
  end

  private
  def comment_params
    params.require(:comment).permit(:title, :body)
  end
end
