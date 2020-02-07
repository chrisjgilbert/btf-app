class AddTransferDeadlineToCompetitions < ActiveRecord::Migration[5.2]
  def change
    add_column :competitions, :transfer_deadline, :datetime
  end
end
