class CreateSurveys < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.references :user
      t.string :hash_url
      t.string :password
      t.string :locality
      t.date :when_date
      t.string :when_text
      t.date :end_votes
      t.string :end_text
      t.date :creation

      t.timestamps
    end
    add_index :surveys, :user_id
  end
end
