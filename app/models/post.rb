class Post
  include MongoMapper::Document
  include Colorable
  plugin MongoMapper::Plugins::Sluggable

  key :content, String
  key :is_private, Boolean, default: false
  key :is_published, Boolean, default: true
  key :is_html, Boolean, default: true
  key :slug, String
  key :tags, Array
  key :title, String
  key :user_id, ObjectId
  timestamps!

  # Relationships.
  belongs_to :user
  many :comments

  many :site_activities, as: :loggable

  # Validations.
  validates_presence_of :title, :user_id, :content
  validates_presence_of :slug, unless: "errors.include?(:title)"
  validates_uniqueness_of :slug

  sluggable :title, method: :to_url, index: false, blacklist: ["new"]

  def is_old?
    self.created_at.year < 2010
  end

  def is_private?
    false
  end

  def to_param
    self.slug
  end

  def tags_as_string
    self.tags.join(",")
  end
end
