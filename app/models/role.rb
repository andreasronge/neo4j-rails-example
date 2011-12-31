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
