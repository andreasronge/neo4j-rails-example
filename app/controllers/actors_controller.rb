class ActorsController < ApplicationController
  before_filter :find_actor, :only => [:show, :edit, :update, :destroy]
  around_filter :neo_tx


  def index
    @actors = Actor.all.nodes
  end

  def create
    @actor = Actor.new
    @actor.update(params[:actor])
    flash[:notice] = 'Actor was successfully created.'
    redirect_to(@actor)
  end

  def update
    @actor.update(params[:actor])
    flash[:notice] = 'Actor was successfully updated.'
    redirect_to(@actor)
  end

  def destroy
    @actor.delete
    redirect_to(actors_url)
  end

  def edit
  end

  def show
    @movies = Movie.all.nodes
  end

  def link
    @actor = Neo4j.load(@_params[:id])
    @movie = Neo4j.load(@_params[:movie_id])
    rel1 = @actor.acted_in.new(@movie)
    rel1.character = @_params[:character]
    rel2 = @movie.has_actor.new(@actor)
    rel2.character = @_params[:character]
    redirect_to(@actor)
  end
  
  def unlink
    @actor = Neo4j.load(params[:id])
    @movie = Neo4j.load(params[:movie_id])
    if @actor.relationships[@movie] then
      @actor.relationships[@movie].delete
    end
    if @movie.relationships[@actor] then
      @movie.relationships[@actor].delete
    end
    redirect_to(@actor)
  end

  def new
    @actor = Actor.value_object.new
  end

  private

  def find_actor
    @actor = Neo4j.load(params[:id])
  end

  private

  def neo_tx
    Neo4j::Transaction.new
    yield
    Neo4j::Transaction.finish
  end
end
