class Comment
  include MongoMapper::EmbeddedDocument

  key :content, String
  key :user_id, ObjectId
  timestamps!
  
  # Relationships.
  belongs_to :user
  embedded_in :post
  
  # Validations.
  validates_presence_of :content, :user_id
end
