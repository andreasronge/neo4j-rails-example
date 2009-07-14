class ActedInController < ApplicationController
  around_filter :neo_tx


  def index
    @actor = Neo4j.load(params[:actor_id])
    @movies = @actor.acted_in.nodes
  end

  def create
    @actor = Neo4j.load(params[:actor_id])
    @movie = Movie.new
    @movie.update(params[:movie])
    @actor.acted_in << @movie
    flash[:notice] = 'Movie was successfully created.'
    redirect_to(@actor)
  end

  def update
    @actor = Neo4j.load(params[:actor_id])
    @movie = Movie.new
    @movie.update(params[:movie])
    @actor.acted_in.new @movie
    @movie.update(params[:movie])
    flash[:notice] = 'Movie was successfully updated.'
    redirect_to(@movie)
  end

  def show
    @movie = Neo4j.load(params[:id])
  end

  def new
    @actor = Neo4j.load(params[:actor_id])
    @movie = Movie.value_object.new
  end

  def edit
    @movie = Neo4j.load(params[:id])
  end

  private

  def neo_tx
    Neo4j::Transaction.new
    yield
    Neo4j::Transaction.finish
  end
end
