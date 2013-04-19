class CreateOptions < ActiveRecord::Migration
  def change
    create_table :options do |t|
      t.references :survey
      t.string :title
      t.string :locality

      t.timestamps
    end
    add_index :options, :survey_id
  end
end
