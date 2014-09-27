class CreateExpenseDetails < ActiveRecord::Migration
  def change
    create_table :expense_details do |t|
      t.date :today
      t.integer :expense_type_id
      t.integer :payment_type_id
      t.integer :amount
      t.string :comment

      t.timestamps
    end
  end
end
