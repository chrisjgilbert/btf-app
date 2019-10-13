class AddPointsToCompetitors < ActiveRecord::Migration[5.2]
  def change
    add_column :competitors, :points, :integer, default: 0
  end
end
