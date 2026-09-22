class CreateGrowthInterests < ActiveRecord::Migration[7.2]
  def change
    # A category (from any assessment) the person has opted in to "learn more" about —
    # typically one they scored lower on. Drives the profile and future class recommendations.
    create_table :growth_interests do |t|
      t.references :user,       null: false, foreign_key: true
      t.references :assessment, null: false, foreign_key: true
      t.string :category, null: false
      t.timestamps
    end
    add_index :growth_interests, [:user_id, :assessment_id, :category], unique: true, name: "idx_growth_interests_unique"
  end
end
