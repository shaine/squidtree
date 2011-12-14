class ArPost < ActiveRecord::Base
  set_table_name "posts"
  belongs_to              :user, :class_name => 'ArUser', :foreign_key=>'user_id'
  has_and_belongs_to_many :tags, :class_name => 'ArTag',  :foreign_key=>'post_id', :join_table=>'posts_tags', :association_foreign_key=>'tag_id'
end
