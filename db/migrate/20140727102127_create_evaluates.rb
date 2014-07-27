class CreateEvaluates < ActiveRecord::Migration
  def change
    create_table :evaluates do |t|
      t.string :name
      t.string :phone
      t.string :service
      t.string :suzhi
      t.string :xiaolv
      t.string :remark
      t.timestamps
    end
  end
end
