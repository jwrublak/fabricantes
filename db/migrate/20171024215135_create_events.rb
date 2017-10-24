class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.integer :object_id
      t.string :class_name
      t.text :change

      t.timestamps
    end
  end
end
