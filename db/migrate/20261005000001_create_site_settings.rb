class CreateSiteSettings < ActiveRecord::Migration[7.2]
  def change
    # Small key/value store for site-wide choices an admin makes in the UI (font, etc.).
    create_table :site_settings do |t|
      t.string :key,   null: false
      t.string :value
      t.timestamps
    end
    add_index :site_settings, :key, unique: true
  end
end
