# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2026_09_15_205329) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "appointments", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "status", default: "unlocked", null: false
    t.datetime "scheduled_at"
    t.string "meeting_preference"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_appointments_on_user_id", unique: true
  end

  create_table "assessment_results", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "assessment_id", null: false
    t.jsonb "answers", default: {}, null: false
    t.jsonb "scores", default: {}, null: false
    t.datetime "completed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assessment_id"], name: "index_assessment_results_on_assessment_id"
    t.index ["user_id", "assessment_id"], name: "index_assessment_results_on_user_id_and_assessment_id", unique: true
    t.index ["user_id"], name: "index_assessment_results_on_user_id"
  end

  create_table "assessments", force: :cascade do |t|
    t.bigint "step_id", null: false
    t.integer "position", null: false
    t.string "slug", null: false
    t.string "title", null: false
    t.text "description"
    t.text "intro"
    t.jsonb "categories", default: {}, null: false
    t.integer "top_n", default: 3, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_assessments_on_slug", unique: true
    t.index ["step_id"], name: "index_assessments_on_step_id"
  end

  create_table "lesson_completions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "lesson_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lesson_id"], name: "index_lesson_completions_on_lesson_id"
    t.index ["user_id", "lesson_id"], name: "index_lesson_completions_on_user_id_and_lesson_id", unique: true
    t.index ["user_id"], name: "index_lesson_completions_on_user_id"
  end

  create_table "lessons", force: :cascade do |t|
    t.bigint "step_id", null: false
    t.integer "position", null: false
    t.string "slug", null: false
    t.string "title", null: false
    t.text "description"
    t.string "kind", default: "video", null: false
    t.string "vimeo_id"
    t.string "vimeo_hash"
    t.text "body"
    t.text "speaker_notes"
    t.boolean "published", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_lessons_on_slug", unique: true
    t.index ["step_id", "position"], name: "index_lessons_on_step_id_and_position", unique: true
    t.index ["step_id"], name: "index_lessons_on_step_id"
  end

  create_table "questions", force: :cascade do |t|
    t.bigint "assessment_id", null: false
    t.integer "position", null: false
    t.string "category", null: false
    t.text "text", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assessment_id", "position"], name: "index_questions_on_assessment_id_and_position", unique: true
    t.index ["assessment_id"], name: "index_questions_on_assessment_id"
  end

  create_table "steps", force: :cascade do |t|
    t.integer "position", null: false
    t.string "slug", null: false
    t.string "title", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["position"], name: "index_steps_on_position", unique: true
    t.index ["slug"], name: "index_steps_on_slug", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "phone"
    t.boolean "admin", default: false, null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "pathway_completed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "appointments", "users"
  add_foreign_key "assessment_results", "assessments"
  add_foreign_key "assessment_results", "users"
  add_foreign_key "assessments", "steps"
  add_foreign_key "lesson_completions", "lessons"
  add_foreign_key "lesson_completions", "users"
  add_foreign_key "lessons", "steps"
  add_foreign_key "questions", "assessments"
end
