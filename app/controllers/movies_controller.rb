class MoviesController < ApplicationController
  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings = Movie.all_ratings
    rating = params[:ratings]
    #@rate = params[:ratings]
    if !session[:checked].nil?
      if rating.nil?
         rating =session[:checked]
      else
         rating = params[:ratings]
         session[:checked] = rating
      end
    else
      session[:checked] = rating
    end
    @sort = params[:sort]
    @selected_ratings = []
    if !rating.nil?
       rating.each_key do |key|
       @selected_ratings << key
    end
    elsif
      @selected_ratings = @all_ratings
    end

    if @sort == 'title'
         @title = 'hilite'
         session[:clicked] = 'title'
    end
    if @sort == 'release_date'
         @release_date = 'hilite'
         session[:clicked] = 'release_date'
    end

    if rating != nil
      rating_array=rating.keys
      if session[:clicked] == 'title'
        @sort = 'title'
        @title = 'hilite'
      end
      if session[:clicked] == 'release_date'
        @sort = 'release_date'
        @release_date = 'hilite'
      end
      @movies = Movie.find(:all,:conditions => ["rating IN (?)",rating_array],:order => @sort)
    elsif
      @movies = Movie.all(:order => @sort)
    end
    
  end


  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
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
