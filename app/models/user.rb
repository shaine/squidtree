class User
  include MongoMapper::Document
  
  key :slug, String
  key :title, String
  key :name, Hash
  key :email, String
  key :password, String
  timestamps!
  
  # Relationships.
  many :comments
  many :links
  many :posts
  
  # Validations.
  validates_presence_of :title, :slug, :name, :email, :password
end
