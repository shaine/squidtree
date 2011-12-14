class CreateArTags < ActiveRecord::Migration
  def change
    create_table :ar_tags do |t|

      t.timestamps
    end
  end
end
