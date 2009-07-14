class Role
  include Neo4j::RelationshipMixin
  property :title, :character
end

