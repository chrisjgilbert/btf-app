class AddFavouriteToCompetitions < ActiveRecord::Migration[5.2]
  def change
    add_reference :competitions, :favourite, index: true
    add_foreign_key :competitions, :competitors, column: :favourite_id
  end
end
