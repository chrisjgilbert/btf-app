class CreatePicks < ActiveRecord::Migration[5.2]
  def change
    create_table :picks do |t|
      t.references :team, foreign_key: true
      t.references :competitor, foreign_key: true

      t.timestamps
    end
  end
end
