class HomesController < ApplicationController
    def top
        @movies = Movie.all.reverse_order.limit(4)
        @all_ranks = Movie.find(Like.group(:movie_id).order('count(movie_id) desc').limit(4).pluck(:movie_id))
        @genres = Genre.all
    end

    def about
    end
end
