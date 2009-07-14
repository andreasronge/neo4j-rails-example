class Actor
    include Neo4j::NodeMixin
    property :name, :phone, :salary
    has_n(:acted_in).to(Movie).relationship(Role)
    index :name
  end
