class CreateCarDetails < ActiveRecord::Migration
  def change
    create_table :car_details do |t|
      t.string :en
      t.string :name
      t.string :model
      t.string :price
      t.string :image
      t.text :detail
      t.timestamps
    end
  end
end
