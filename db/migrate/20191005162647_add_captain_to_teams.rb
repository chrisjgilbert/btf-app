class AddCaptainToTeams < ActiveRecord::Migration[5.2]
  def change
    add_reference :teams, :captain, index: true
    add_foreign_key :teams, :competitors, column: :captain_id
  end
end
