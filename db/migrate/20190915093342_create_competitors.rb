class CreateCompetitors < ActiveRecord::Migration[5.2]
  def change
    create_table :competitors do |t|
      t.string :name
      t.references :competition, foreign_key: true

      t.timestamps
    end
  end
end
