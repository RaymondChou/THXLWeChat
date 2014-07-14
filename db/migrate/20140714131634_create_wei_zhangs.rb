class CreateWeiZhangs < ActiveRecord::Migration
  def change
    create_table :wei_zhangs do |t|
      t.string :licence, :limit => 16
      t.string :engine_code, :limit => 6
      t.string :result, :limit => 4000
      t.timestamps
    end
  end
end
