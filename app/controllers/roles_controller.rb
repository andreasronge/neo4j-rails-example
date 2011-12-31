class RolesController < ApplicationController

  def show
    @role = Role.find(params[:id])
  end

  def new
    @movie = Movie.find(params[:movie_id])
    @actor = Actor.find(params[:actor_id])
    @role = Role.new
  end

  def create
    @movie = Movie.find(params[:movie_id])
    @actor = Actor.find(params[:actor_id])
    @role = @actor.roles_rels.connect(@movie, params[:role])
    @role.save
    redirect_to role_path(@role.id)
  end
end
