class CreateProdutos < ActiveRecord::Migration[5.1]
  def change
    create_table :produtos do |t|
      t.string :nome
      t.integer :codigo
      t.references :fabricante

      t.timestamps
    end
  end
end
