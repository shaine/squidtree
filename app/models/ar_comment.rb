class ArComment < ActiveRecord::Base
  set_table_name "comments"
  belongs_to :user, :class_name => 'ArUser', :foreign_key=>'user_id'
  belongs_to :post, :class_name => 'ArPost', :foreign_key=>'post_id'
end
