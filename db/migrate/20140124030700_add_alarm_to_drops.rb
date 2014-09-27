class AddAlarmToDrops < ActiveRecord::Migration
  def change
    add_column :drops, :is_alarm, :integer
  end
end
