class AddPhoneCountryToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :phone_country, :string, limit: 2, default: "US", null: false
  end
end
