class Comment
  include MongoMapper::EmbeddedDocument

  key :content, String
  
  key :user_id,   ObjectId
  timestamps!
  
  # Relationships.
  belongs_to :user
end
