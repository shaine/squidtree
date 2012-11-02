class User
  include MongoMapper::Document
  plugin MongoMapper::Plugins::Sluggable

  key :slug, String
  key :uid, String
  key :first_name, String
  key :last_name, String
  key :email, String
  key :alias, String
  key :role, String, :default => "reader"
  key :old_post_whitelisted, Boolean, :default => false
  timestamps!

  # Relationships.
  many :comments
  many :links
  many :posts

  # Validations.
  validates_presence_of :first_name, :last_name, :email, :slug
  validates_uniqueness_of :uid, :slug, :email, :alias

  sluggable :alias, :method => :to_url, :index => false

  def to_param
    slug # or whatever you set :url_attribute to
  end

  def name
    self.first_name + " " + self.last_name
  end

  def to_param
    self.slug
  end

  def admin?
    ["admin"].include? self.role
  end

  def editor?
    ["editor", "admin"].include? self.role
  end

  def reader?
    !self.uid.nil?
  end
end
