class CreateUserCars < ActiveRecord::Migration
  def change
    create_table :user_cars do |t|
      t.string :car
      t.string :modal
      t.string :licence
      t.string :name
      t.string :phone
      t.string :licence_time
      t.string :last_baoxian_time
      t.integer :last_baoxian_price
      t.string :last_baoyang_time
      t.integer :last_baoyang_run_count
      t.integer :last_baoyang_price
      t.timestamps
    end
  end
end
