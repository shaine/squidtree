class Comment
  include MongoMapper::EmbeddedDocument

  key :content, String
  key :user_id, ObjectId
  key :created_at, Time
  
  # Relationships.
  belongs_to :user
  embedded_in :post
  
  many :site_activities, :as => :loggable
  
  # Validations.
  validates_presence_of :content, :user_id
end
