class CreatePackages < ActiveRecord::Migration
  def change
    create_table :packages do |t|
      t.string :name
      t.text :channels
      t.decimal :price, precision: 8, scale: 2

      t.timestamps
    end
  end
end
