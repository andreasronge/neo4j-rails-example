class MoviesController < ApplicationController
#  before_filter :find_movie, :only => [:show, :edit, :update, :destroy, :link, :unlink]
  around_filter :neo_tx


  def index
    @movies = Movie.all.nodes
  end

  def create
    @movie = Movie.new
    @movie.update(params[:movie])
    flash[:notice] = 'Movie was successfully created.'
    redirect_to(@movie)
  end

  def update
    @movie.update(params[:movie])
    flash[:notice] = 'Movie was successfully updated.'
    redirect_to(@movie)
  end

  def destroy
    @movie.delete
    redirect_to(movies_url)
  end

  def edit
  end

  def show
    @actors = Actor.all.nodes
  end

  def new
    @movie = Movie.value_object.new
  end
  
  def link
    @actor = Neo4j.load(params[:actor_id])
    rel1 = @actor.acted_in.new(@movie)
    rel1.character = params[:character]
    redirect_to(@movie)
  end
  
  def unlink
    relationship = Neo4j.load_relationship(params[:rel_id])
    relationship.delete
    redirect_to(@movie)
  end

  private


  private

  def neo_tx
    Neo4j::Transaction.new
    @movie = Neo4j.load(params[:id]) if params[:id]
    yield
    Neo4j::Transaction.finish
  end
end
