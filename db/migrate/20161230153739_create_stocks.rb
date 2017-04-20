class CreateStocks < ActiveRecord::Migration[5.0]
  def change
    create_table :stocks do |t|
      t.references :user, foreign_key: true
      t.float :price
      t.integer :shares

      t.timestamps
    end
  end
end
