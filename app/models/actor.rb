class Actor < Neo4j::Model
  rule(:all)

  property :name
  property :born

  has_n(:roles).to(Movie).relationship(Role)
end
