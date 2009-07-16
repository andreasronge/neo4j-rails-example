class ActorsController < ApplicationController
#  before_filter :find_actor, :only => [:show, :edit, :update, :destroy, :link, :unlink]
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
    @movie = Neo4j.load(params[:movie_id])
    rel1 = @actor.acted_in.new(@movie)
    rel1.character = params[:character]
    redirect_to(@actor)
  end
  
  def unlink
    @movie = Neo4j.load(params[:movie_id])
    @actor.relationships.each do |relationship|
      if ((relationship.character == params[:character]) && (relationship.end_node.neo_node_id == @movie.neo_node_id)) then
        relationship.delete
      end
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
    @actor = Neo4j.load(params[:id]) if params[:id]
    yield
    Neo4j::Transaction.finish
  end
end
