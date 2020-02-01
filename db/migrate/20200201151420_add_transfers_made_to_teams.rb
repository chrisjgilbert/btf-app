class AddTransfersMadeToTeams < ActiveRecord::Migration[5.2]
  def change
    add_column :teams, :transfers_made, :integer, default: 0
  end
end
