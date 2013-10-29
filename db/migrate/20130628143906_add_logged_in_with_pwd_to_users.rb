class AddLoggedInWithPwdToUsers < ActiveRecord::Migration
  def up
  	add_column :users, :logged_in_with_pwd, :boolean
  end

  def down
  	remove_column :users, :logged_in_with_pwd
  end
end
