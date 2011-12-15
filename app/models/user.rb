class User
  include MongoMapper::Document
  plugin MongoMapper::Plugins::Sluggable
  
  key :slug, String
  key :first_name, String
  key :last_name, String
  key :alias, String
  timestamps!
  
  # Relationships.
  many :comments
  many :links
  many :posts
  
  # Validations.
  validates_presence_of :first_name, :last_name#, :slug
  
  before_validation :slugify
  
  def to_param
    slug # or whatever you set :url_attribute to
  end
  
  def url
    "/blog/users/" + (slug || '')
  end
  
  def name
    first_name + ' ' + last_name
  end
  
  private
  def slugify_on_create
    if !persisted?
      slug = (first_name + ' ' + last_name).parameterize
    end
  end
end
