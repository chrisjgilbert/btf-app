class AddEndDateToCompetitions < ActiveRecord::Migration[5.2]
  def change
    add_column :competitions, :end_date, :datetime, default: Date.today.next_year.end_of_year
  end
end
