class AddPrizeMoneyToLeagues < ActiveRecord::Migration[5.2]
  def change
    add_column :leagues, :prize_money, :integer, default: 0
  end
end
