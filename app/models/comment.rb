class Comment
  include MongoMapper::EmbeddedDocument
  include Colorable

  key :content, String
  key :user_id, ObjectId
  key :created_at, Time

  attr_protected :user_id

  # Relationships.
  belongs_to :user
  embedded_in :post

  many :site_activities, :as => :loggable

  # Validations.
  validates_presence_of :content, :user_id

  def self.find(id)
    unless id.instance_of?(BSON::ObjectId)
      id = BSON::ObjectId.from_string(id)
    end

    post = Post.first("comments._id" => id)
    unless post.nil?
      post.comments.detect do |comment|
        comment._id == id
      end
    else
      nil
    end
  end

  class << self
    alias :find_by_id :find
  end

  def url
    "/blog/" + post.slug + "/"
  end

  def anchor
    "comment_" + self.index.+(1).to_s
  end

  def index
    self.post.comments.index self
  end
end
