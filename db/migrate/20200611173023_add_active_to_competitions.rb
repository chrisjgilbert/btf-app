class AddActiveToCompetitions < ActiveRecord::Migration[5.2]
  def change
    add_column :competitions, :active, :boolean, default: false
  end
end
