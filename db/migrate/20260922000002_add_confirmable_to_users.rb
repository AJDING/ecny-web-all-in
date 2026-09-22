class AddConfirmableToUsers < ActiveRecord::Migration[7.2]
  def up
    add_column :users, :confirmation_token, :string
    add_column :users, :confirmed_at, :datetime
    add_column :users, :confirmation_sent_at, :datetime
    add_column :users, :unconfirmed_email, :string   # holds a pending email change until it is verified
    add_index  :users, :confirmation_token, unique: true
    # Everyone who already has an account is treated as verified.
    execute "UPDATE users SET confirmed_at = NOW() WHERE confirmed_at IS NULL"
  end

  def down
    remove_index  :users, :confirmation_token
    remove_column :users, :unconfirmed_email
    remove_column :users, :confirmation_sent_at
    remove_column :users, :confirmed_at
    remove_column :users, :confirmation_token
  end
end
