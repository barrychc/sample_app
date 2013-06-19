#9.4.1 rails generate migration add_admin_to_users admin:boolean, then manually add default: false
class AddAdminToUsers < ActiveRecord::Migration
  def change
    add_column :users, :admin, :boolean, default: false
  end
end
