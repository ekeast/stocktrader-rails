class AddSymbolToStocks < ActiveRecord::Migration[5.0]
  def change
    add_column :stocks, :symbol, :string
  end
end
