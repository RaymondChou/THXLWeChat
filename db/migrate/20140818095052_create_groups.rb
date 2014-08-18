class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.string :phone
      t.string :activity
      t.timestamps
    end
  end
end
