class RemoveTodayFromSegments < ActiveRecord::Migration
  def change
    remove_column :segments, :today, :date
  end
end
