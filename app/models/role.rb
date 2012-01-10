# A Role is a relationship between an Actor and a Movie.
# 
# === To make a new Role, do this
#
#   @actor = Actor.create( ... )
#   @movie = Movie.create( ... )
#   role_params = {:as => 'Captain Haddock'}
#   @role = @actor.roles_rels.connect(@movie, role_params)
#   @role.save
#
class Role < Neo4j::Rails::Relationship
  property :as

  # this is necessary to be able to make forms with the form_for helper
  def to_key
    persisted? ? [id] : nil
  end

  # this is for the routing helpers
  def to_param
    persisted? ? neo_id.to_s : nil
  end
end
