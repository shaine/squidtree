class Contact
  include MongoMapper::Document

  key :name, String
  key :email, String
  key :message, String

  validates_presence_of :name, :email, :message

end
