class CreateOrderDrives < ActiveRecord::Migration
  def change
    create_table :order_drives do |t|
      t.string :name
      t.string :phone
      t.string :car
      t.date :time
      t.string :remark
      t.string
      t.timestamps
    end
  end
end
