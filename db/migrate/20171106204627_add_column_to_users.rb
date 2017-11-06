class AddColumnToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :provider, :string
    add_column :users, :uid, :string
    add_column :users, :name, :string
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :gender, :string
    add_column :users, :image_url, :string
    add_column :users, :authentication_token, :text
    add_column :users, :authentication_token_created_at, :datetime
    add_index :users, :authentication_token, unique: true
  end
end
