class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.references :option
      t.references :user
      t.string :username

      t.timestamps
    end
    add_index :votes, :option_id
    add_index :votes, :user_id
    add_index :votes, :username
  end
end
