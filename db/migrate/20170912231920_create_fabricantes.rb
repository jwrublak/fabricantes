class CreateFabricantes < ActiveRecord::Migration[5.1]
  def change
    create_table :fabricantes do |t|
      t.string :nome
      t.integer :codigo

      t.timestamps
    end
  end
end
