class HomesController < ApplicationController
    def top
        @movies = Movie.all
    end
    
    def about
    end
end
