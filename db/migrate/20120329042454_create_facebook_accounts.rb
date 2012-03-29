class CreateFacebookAccounts < ActiveRecord::Migration
  def change
    create_table :facebook_accounts do |t|
      t.float :fb_id
      t.string :name
      t.references :user

      t.timestamps
    end
    add_index :facebook_accounts, :user_id
  end
end
