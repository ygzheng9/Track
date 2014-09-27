class AddDropToSegments < ActiveRecord::Migration
  def change
    add_column :segments, :drop_id, :integer
  end
end
