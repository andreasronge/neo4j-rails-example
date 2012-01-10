class RolesController < ApplicationController
  around_filter Neo4j::Rails::Transaction, :only => [:edit, :create, :update, :destroy]

  def show
    @role = Role.find(params[:id])
  end

  # Requires that the params :movie_id and :actor_id be set.
  # Since a role is a relationship, it does not make sense
  # to create one without knowing the movie and actor.
  def new
    @movie = Movie.find(params[:movie_id])
    @actor = Actor.find(params[:actor_id])
    @role = Role.new
  end

  # Requires that the params :movie_id and :actor_id be set,
  # just like Role#new.  See above.
  def create
    @movie = Movie.find(params[:movie_id])
    @actor = Actor.find(params[:actor_id])
    @role = @actor.roles_rels.connect(@movie, params[:role])
    @role.save
    redirect_to role_path(@role.id)
  end

  def edit
    @role = Role.find(params[:id])
    @actor = @role.start_node
    @movie = @role.end_node
  end
  
  def update
    @role = Role.find(params[:id])
    if @role.update_attributes(params[:role])
      redirect_to(@role, :notice => 'Role was successfully updated.')
    else
      @actor = @role.start_node
      @movie = @role.end_node
      render :action => "edit"
    end
  end

  def destroy
    @role = Role.find(params[:id])
    @actor = @role.start_node
    @role.destroy
    redirect_to actor_path(@actor)
  end
end
