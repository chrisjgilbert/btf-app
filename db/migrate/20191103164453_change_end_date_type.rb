class ChangeEndDateType < ActiveRecord::Migration[5.2]
  def change
    change_column :competitions, :end_date, :date
  end
end
