class CreateLaborClaims < ActiveRecord::Migration
  def change
    create_table :labor_claims do |t|
      t.date :today
      t.integer :project_id
      t.integer :hours
      t.string :comment

      t.timestamps
    end
  end
end
