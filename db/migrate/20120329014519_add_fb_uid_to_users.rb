class AddFbUidToUsers < ActiveRecord::Migration
  def change
    add_column :users, :fb_uid, :float

  end
end
