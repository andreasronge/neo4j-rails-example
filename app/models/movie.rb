class Movie < Neo4j::Model
  rule(:all)

  property :title
  property :year

  # The following line lets you create relationships between Actors and Movies.
  #
  # === Example
  #
  #   humphrey = Actor.new(:name => 'Humphrey Bogart')
  #   m = Movie.new(:title => 'The African Queen')
  #   m.actors << humphrey
  #   m.save
  #   m.actors.first  # => returns humphrey
  #
  has_n(:actors).from(Actor, :roles).relationship(Role)
end
