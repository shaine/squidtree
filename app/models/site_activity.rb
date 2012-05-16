class SiteActivity
  include MongoMapper::Document

  key :user_id, ObjectId
  timestamps!

  # Relationships.
  belongs_to :user

  belongs_to :loggable, :polymorphic => true

  # Validations.
  validates_presence_of :user_id
end
