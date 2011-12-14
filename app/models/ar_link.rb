class ArLink < ActiveRecord::Base
  set_table_name "links"
  belongs_to :user, :class_name => 'ArUser', :foreign_key=>'user_id'
end
