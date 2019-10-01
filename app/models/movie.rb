class Movie < ActiveRecord::Base
    #attr_accessor :title, :rating, :description, :release_date
    
    #def self.all_ratings
    #    res = {}
    #    self.select(:rating).uniq.each {
    #        |movie|
    #        res[movie.rating] = 1
    #    }
    #    return res
    #end
    
    def self.all_ratings
       %w[G PG PG-13 R NC-17] 
    end
    
    def self.with_ratings(ratings)
       return Movie.where(:rating => ratings) 
    end
    
    def self.rating_sort(movies, chosen_ratings)
    @allowed_movies = Array.new
    movies.each {
      |movie|
      chosen_ratings.each {
        |key, value|
        if movie.rating == key
          @allowed_movies << movie
        end
      }
    }
   return @allowed_movies
   
  end
  
end
