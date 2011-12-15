class User
  include MongoMapper::Document
  
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
  
  scope :recent, sort(:created_at.desc).limit(3)
  
  #acts_as_url :first_name, :url_attribute => :slug
  
  def to_param
    slug # or whatever you set :url_attribute to
  end
end
