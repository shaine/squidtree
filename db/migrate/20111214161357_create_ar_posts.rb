class CreateArPosts < ActiveRecord::Migration
  def change
    create_table :ar_posts do |t|

      t.timestamps
    end
  end
end
