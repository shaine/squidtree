class Tag
  include MongoMapper::EmbeddedDocument

  key :title, String
  timestamps!
  
  # Relationships.
  embedded_in :post
  
  # Validations.
  validates_presence_of :title
end
