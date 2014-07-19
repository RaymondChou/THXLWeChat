class AddCar < ActiveRecord::Migration
  def change
    add_column :cars, :name, :string
    add_column :cars, :en, :string
    add_column :cars, :price, :string
    add_column :cars, :image, :string
  end
end
