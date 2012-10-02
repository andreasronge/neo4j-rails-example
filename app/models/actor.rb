class Actor < Neo4j::Rails::Model
  property :name
  property :born

  # The has_n method declares a relationship between Actors and Movies.
  # It defines convenience methods:
  # @actor.movies returns an array of movies.
  # @actor.movies_rels returns an array of the Relationships connecting @actor to the movies.
  #
  # === Example
  #
  #   humphrey = Actor.new(:name => 'Humphrey Bogart')
  #   african_queen = Movie.new(:title => 'The African Queen')
  #   humphrey.movies << african_queen
  #   humphrey.save
  #
  #   humphrey.movies.first.title  # => 'The African Queen'
  #
  #   humphrey.movies_rels.first.class # => Role
  #
  # Here we specify that the relationship will be an instance of the Role class.
  has_n(:roles).to(Movie).relationship(Role)
end
