class ArUser < ActiveRecord::Base
  set_table_name "users"
  has_many :comments, :class_name=>"ArComment", :foreign_key=>'user_id'
  has_many :links,    :class_name=>"ArLink",    :foreign_key=>'user_id'
  has_many :posts,    :class_name=>"ArPost",    :foreign_key=>'user_id'
end
