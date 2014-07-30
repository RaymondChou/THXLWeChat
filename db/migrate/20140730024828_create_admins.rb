class CreateAdmins < ActiveRecord::Migration
  def change
    create_table(:admins) do |t|
      ## Database authenticatable
      t.string :admin_name,         :null => false, :default => '', :comment => '管理员账号'
      t.string :admin_full_name,    :null => false, :default => '', :comment => '管理员姓名'
      t.string :encrypted_password, :null => false, :default => '', :comment => '已加密的密码'

      ## Rememberable
      t.datetime :remember_created_at, :comment => '记住登录时间'

      ## Trackable
      t.integer  :sign_in_count, :default => 0, :comment => '登录次数'
      t.datetime :current_sign_in_at, :comment => '本次登录时间'
      t.datetime :last_sign_in_at, :comment => '最后登录时间'
      t.string   :current_sign_in_ip, :comment => '当前登录ip'
      t.string   :last_sign_in_ip, :comment => '最后登录ip'

      t.timestamps
    end
  end
end
