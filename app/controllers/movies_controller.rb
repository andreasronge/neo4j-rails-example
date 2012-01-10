class MoviesController < ApplicationController
  around_filter Neo4j::Rails::Transaction, :only => [:edit, :create, :update, :destroy]
  
  def index
    @movies = Movie.all
  end
  
  def show
    @movie = Movie.find(params[:id])
  end
  
  def new
    @movie = Movie.new
  end
  
  def edit
    @movie = Movie.find(params[:id])
  end
  
  def create
    @movie = Movie.new(params[:movie])
    
    if @movie.save
      redirect_to(@movie, :notice => 'Movie was successfully created.')
    else
      render :action => "new"
    end
    
  end
  
  
  def update
    @movie = Movie.find(params[:id])
    if @movie.update_attributes(params[:movie])
      redirect_to(@movie, :notice => 'Movie was successfully updated.') 
    else
      render :action => "edit"
    end
  end
  
  
   def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to(movies_url)
  end

  def add_role
    @movie = Movie.find(params[:id])
    @actors = Actor.all
  end
end

