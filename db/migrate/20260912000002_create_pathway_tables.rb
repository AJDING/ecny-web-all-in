class CreatePathwayTables < ActiveRecord::Migration[7.2]
  def change
    create_table :steps do |t|
      t.integer :position,    null: false
      t.string  :slug,        null: false
      t.string  :title,       null: false
      t.text    :description
      t.timestamps
    end
    add_index :steps, :slug, unique: true
    add_index :steps, :position, unique: true

    create_table :lessons do |t|
      t.references :step, null: false, foreign_key: true
      t.integer :position,    null: false
      t.string  :slug,        null: false
      t.string  :title,       null: false
      t.text    :description                       # one-liner shown on My Progress
      t.string  :kind,        null: false, default: "video"  # "video" | "text"
      t.string  :vimeo_id                          # numeric Vimeo video id
      t.string  :vimeo_hash                        # for unlisted videos (the ?h= part)
      t.text    :body                              # text lessons / notes under the video (Markdown-lite)
      t.text    :speaker_notes                     # internal: script outline for recording
      t.boolean :published,   null: false, default: true
      t.timestamps
    end
    add_index :lessons, :slug, unique: true
    add_index :lessons, [:step_id, :position], unique: true

    create_table :lesson_completions do |t|
      t.references :user,   null: false, foreign_key: true
      t.references :lesson, null: false, foreign_key: true
      t.timestamps
    end
    add_index :lesson_completions, [:user_id, :lesson_id], unique: true

    create_table :assessments do |t|
      t.references :step, null: false, foreign_key: true
      t.integer :position,   null: false
      t.string  :slug,       null: false
      t.string  :title,      null: false
      t.text    :description
      t.text    :intro                              # shown above the questions
      t.jsonb   :categories, null: false, default: {} # { "Worship" => { "summary" => "...", "serve" => [..] } }
      t.integer :top_n,      null: false, default: 3
      t.timestamps
    end
    add_index :assessments, :slug, unique: true

    create_table :questions do |t|
      t.references :assessment, null: false, foreign_key: true
      t.integer :position, null: false
      t.string  :category, null: false
      t.text    :text,     null: false
      t.timestamps
    end
    add_index :questions, [:assessment_id, :position], unique: true

    create_table :assessment_results do |t|
      t.references :user,       null: false, foreign_key: true
      t.references :assessment, null: false, foreign_key: true
      t.jsonb :answers, null: false, default: {}   # { "question_id" => 1..5 }
      t.jsonb :scores,  null: false, default: {}   # { "category" => total }
      t.datetime :completed_at
      t.timestamps
    end
    add_index :assessment_results, [:user_id, :assessment_id], unique: true

    create_table :appointments do |t|
      t.references :user, null: false, foreign_key: true, index: { unique: true }
      t.string   :status, null: false, default: "unlocked" # unlocked | scheduled | completed
      t.datetime :scheduled_at
      t.string   :meeting_preference                       # in person | phone | video
      t.text     :notes                                    # team notes (admin)
      t.timestamps
    end
  end
end
