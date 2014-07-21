class CreateOrderCares < ActiveRecord::Migration
  def change
    create_table :order_cares do |t|
      t.string :name
      t.string :phone
      t.string :licence
      t.string :run_count
      t.date :time
      t.string :car
      t.string :care_type
      t.string :remark
      t.timestamps
    end
  end
end
