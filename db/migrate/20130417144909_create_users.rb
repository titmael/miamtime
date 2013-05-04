class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :password
      t.string :hash_validation
      t.string :email

      t.timestamps
    end
    add_index :users, :name
    add_index :users, :email
    add_index :users, :hash_validation
  end
end
