class Movie < ActiveRecord::Base
    #attr_accessor :title, :rating, :description, :release_date
    
    def self.all_ratings
       result = Hash.new
       self.select(:rating).uniq.each {
         |movie|
         result[movie.rating] = 1
       }
       return result
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
