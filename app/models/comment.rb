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

  def self.find_by_id(id)
    post = Post.where("comments._id" => id).first

    post.comments.each do |comment|
      if comment._id == id
        return comment
      end
    end
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
