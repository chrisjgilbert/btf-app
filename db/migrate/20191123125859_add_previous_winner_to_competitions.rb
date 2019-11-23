class AddPreviousWinnerToCompetitions < ActiveRecord::Migration[5.2]
  def change
    add_column :competitions, :previous_winner, :string
  end
end
