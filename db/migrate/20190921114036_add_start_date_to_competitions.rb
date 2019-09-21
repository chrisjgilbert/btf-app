class AddStartDateToCompetitions < ActiveRecord::Migration[5.2]
  def change
    add_column :competitions, :start_date, :date
  end
end
