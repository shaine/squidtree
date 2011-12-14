class CreateArLinks < ActiveRecord::Migration
  def change
    create_table :ar_links do |t|

      t.timestamps
    end
  end
end
