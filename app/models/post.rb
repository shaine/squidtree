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
  
  def url
    "/blog/#{slug}/"
  end
end
