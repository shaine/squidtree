class CreateArUsers < ActiveRecord::Migration
  def change
    create_table :ar_users do |t|

      t.timestamps
    end
  end
end
