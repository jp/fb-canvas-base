class CreateFacebookNodes < ActiveRecord::Migration
  def change
    create_table :facebook_nodes do |t|
      t.references :user
      t.references :facebook_account

      t.timestamps
    end
    add_index :facebook_nodes, :user_id
    add_index :facebook_nodes, :facebook_account_id
  end
end
