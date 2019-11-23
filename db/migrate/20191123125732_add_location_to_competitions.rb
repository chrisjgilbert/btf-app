class AddLocationToCompetitions < ActiveRecord::Migration[5.2]
  def change
    add_column :competitions, :location, :string
  end
end
