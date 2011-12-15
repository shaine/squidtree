class Post
  include MongoMapper::Document

  key :slug, String
  key :title, String
  key :content, String
  key :user_id, ObjectId
  timestamps!
  
  # Relationships.
  belongs_to :user
  many :comments
  
  # Validations.
  validates_presence_of :title, :slug, :user_id
end
