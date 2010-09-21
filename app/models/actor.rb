class Actor < Neo4j::Model
  rule(:all)
  
  property :name
  property :born
end