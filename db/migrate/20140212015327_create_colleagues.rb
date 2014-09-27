class CreateColleagues < ActiveRecord::Migration
  def change
    create_table :colleagues do |t|
      t.string :name
      t.text :remark

      t.timestamps
    end
  end
end
