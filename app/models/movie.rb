class Movie < Neo4j::Rails::Model
  property :title
  property :year

  # The has_n method declares a relationship between Actors and Movies.
  # It defines convenience methods:
  # @movie.actors returns an array of actors.
  # @movie.actors_rels returns an array of the Relationships connecting @movie to the actors.
  #
  # === Example
  #
  #   humphrey = Actor.new(:name => 'Humphrey Bogart')
  #   m = Movie.new(:title => 'The African Queen')
  #   m.actors << humphrey
  #   m.save
  #
  #   m.actors.first  # => humphrey
  #
  #   m.actors_rels.first # 
  #
  # Here we specify that the relationship will be an instance of the Role class.
  has_n(:actors).from(Actor, :roles).relationship(Role)
end
