class CreateSubscribers < ActiveRecord::Migration
  def change
    create_table :subscribers do |t|
      t.string :smartcard_number
      t.string :name
      t.string :address
      t.integer :cycle_starts_on
      t.text :packages
      t.text :channels
      t.decimal :subscription_amount, precision: 8, scale: 2
      t.boolean :status, default: true, null: false 

      t.timestamps
    end
  end
end
