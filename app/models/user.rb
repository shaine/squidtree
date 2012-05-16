class User
  include MongoMapper::Document
  plugin MongoMapper::Plugins::Sluggable

  key :slug, String
  key :uid, String
  key :first_name, String
  key :last_name, String
  key :alias, String
  timestamps!

  # Relationships.
  many :comments
  many :links
  many :posts

  # Validations.
  validates_presence_of :first_name, :last_name, :slug

  sluggable :alias, :method => :to_url, :index => false

  def to_param
    slug # or whatever you set :url_attribute to
  end

  def name
    first_name + ' ' + last_name
  end

  def to_param
    self.slug
  end
end
