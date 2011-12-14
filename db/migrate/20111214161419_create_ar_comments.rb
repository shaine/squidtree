class CreateArComments < ActiveRecord::Migration
  def change
    create_table :ar_comments do |t|

      t.timestamps
    end
  end
end
