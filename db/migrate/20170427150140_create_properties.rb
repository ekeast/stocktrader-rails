class CreateProperties < ActiveRecord::Migration[5.0]
  def change
    create_table :properties do |t|
      t.string :symbol
      t.integer :shares
      t.float :purchased_price

      t.timestamps
    end
  end
end
