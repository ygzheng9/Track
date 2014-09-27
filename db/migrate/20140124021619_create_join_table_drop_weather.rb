class CreateJoinTableDropWeather < ActiveRecord::Migration
  def change
    create_join_table :drops, :weathers do |t|
      # t.index [:drop_id, :weather_id]
      # t.index [:weather_id, :drop_id]
    end
  end
end
