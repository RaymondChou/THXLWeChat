class CreateAds < ActiveRecord::Migration
  def change
    create_table :ads do |t|
      t.integer :sort
      t.string :url
      t.string :image
      t.timestamps
    end
  end
end
