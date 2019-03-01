class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.belongs_to :account, index: true
      t.decimal :amount
      t.integer :to_id, null: false
      t.integer :from_id, null: false
      t.string :type
      t.timestamps
    end
  end
end
