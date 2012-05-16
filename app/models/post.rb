class Post
  include MongoMapper::Document
  include Colorable
  plugin MongoMapper::Plugins::Sluggable

  key :slug, String
  key :title, String
  key :content, String
  key :tags, Array
  key :user_id, ObjectId
  timestamps!

  # Relationships.
  belongs_to :user
  many :comments

  many :site_activities, :as => :loggable

  # Validations.
  validates_presence_of :title, :slug, :user_id

  sluggable :title, :method => :to_url, :index => false

  def is_old?
    self.created_at.strftime("%Y").to_i < 2010
  end

  def to_param
    self.slug
  end
end
