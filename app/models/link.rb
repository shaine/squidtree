class Link
  include MongoMapper::Document

  key :url, String
  key :title, String
  key :comment, String

end
