class Movie
   include Neo4j::NodeMixin
   property :title
   property :year

   # defines a method for traversing incoming acted_in relationships from Actor
   # has_n(:has_actor).to(Actor).relationship(Role)
   has_n(:actors).from(Actor, :acted_in)
 end
