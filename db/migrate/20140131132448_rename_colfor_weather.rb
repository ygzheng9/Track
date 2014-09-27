class RenameColforWeather < ActiveRecord::Migration
  def change
    rename_column :weathers, :Condition, :name
  end
end
