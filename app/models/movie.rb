class Movie < Neo4j::Model
  rule(:all)

  property :title
  property :year
end
