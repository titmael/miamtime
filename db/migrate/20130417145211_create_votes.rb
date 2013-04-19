class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.references :option
      t.references :user

      t.timestamps
    end
    add_index :votes, :option_id
    add_index :votes, :user_id
  end
end
