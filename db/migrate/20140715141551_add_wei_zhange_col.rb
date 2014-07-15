class AddWeiZhangeCol < ActiveRecord::Migration
  def change
    add_column :wei_zhangs, :job_status, :integer
    add_column :wei_zhangs, :job_id, :string
  end
end
