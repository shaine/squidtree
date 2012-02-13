class Link
  include MongoMapper::Document
  include Colorable

  key :url, String
  key :title, String
  key :comment, String
  key :user_id, ObjectId
  timestamps!

  # Relationships.
  belongs_to :user

  # Validations.
  validates_presence_of :url, :title, :user_id
end
