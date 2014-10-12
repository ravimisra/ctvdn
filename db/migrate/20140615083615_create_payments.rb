class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.string  :payment_ref
      t.integer :subscriber_id
      t.decimal :amount, precision: 8, scale: 2
      t.date    :for_cycle
      t.integer :agent_id
      t.date    :collected_on
      t.integer :created_by
      t.integer :updated_by

      t.timestamps
    end
  end
end
