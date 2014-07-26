class CreateOrderDrives < ActiveRecord::Migration
  def change
    create_table :order_drives do |t|
      t.string :name
      t.string :phone
      t.string :car
      t.string :modal
      t.string :time
      t.string :remark
      t.timestamps
    end
  end
end
