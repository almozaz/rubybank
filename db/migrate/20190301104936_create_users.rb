class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :login, unique: true
      t.string :password
      t.string :password_confirmation
      t.timestamps
    end
  end
end
