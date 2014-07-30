class Admin < ActiveRecord::Base
  devise :database_authenticatable,
         :rememberable, :trackable, :timeoutable, :timeoutable

  attr_accessible :admin_name, :admin_full_name, :password, :password_confirmation, :remember_me
  validates_presence_of :admin_name, :admin_full_name
  validates_uniqueness_of :admin_name, :admin_full_name
  validates_confirmation_of :password
  validates_length_of :admin_name, :minimum => 6
  validates_length_of :password, :minimum => 6, :allow_nil => true
end
