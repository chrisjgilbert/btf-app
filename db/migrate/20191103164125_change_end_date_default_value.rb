class ChangeEndDateDefaultValue < ActiveRecord::Migration[5.2]
  def change
    change_column_default :competitions, :end_date, nil
  end
end
