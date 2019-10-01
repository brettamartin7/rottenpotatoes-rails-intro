class MoviesController < ApplicationController

  
  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end
  
  
  def index
    #Check if params has any key, if not and session has values set params to session hash
    if(!params.has_key?(:sort_by) && !params.has_key?(:ratings))
      if(session.has_key?(:sort_by) || session.has_key?(:ratings))
        redirect_to movies_path(:sort_by => session[:sort_by], :ratings => session[:ratings])
      end
    end
    
    
    @all_ratings = Movie.all_ratings.keys
    @chosen_ratings = params[:ratings]
     
    #Check if ratings has not been refreshed
    if (@chosen_ratings != nil)
      ratings = @chosen_ratings.keys
      session[:ratings] = @chosen_ratings
    else
      if(!params.has_key?(:commit) && !params.has_key?(:sort_by))
        ratings = Movie.all_ratings.keys
        session[:ratings] = Movie.all_ratings
      else
        ratings = session[:ratings].keys
      end
    end
    
    #check if we have a sort_by key, if so store it in session
    if (params.has_key?(:sort_by))
      session[:sort_by] = params[:sort_by]
      sort = session[:sort_by]
    else
      sort = session[:sort_by]
    end
    
    @movies = Movie.order(sort).with_ratings(ratings)
    @final_ratings = ratings
    
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end
  

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
