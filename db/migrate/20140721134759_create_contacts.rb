class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :zhiwei
      t.string :info
      t.integer :star, :default => 5
      t.string :phone
      t.integer :sort
      t.string :avatar
      t.boolean :front, :default => false
      t.timestamps
    end
  end
end
