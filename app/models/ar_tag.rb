class ArTag < ActiveRecord::Base
  set_table_name "tags"
  has_and_belongs_to_many :posts, :class_name => 'ArPost', :foreign_key=>'tag_id', :join_table=>'posts_tags', :association_foreign_key=>'post_id'
end
