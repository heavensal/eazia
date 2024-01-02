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

ActiveRecord::Schema[7.1].define(version: 2024_01_02_182609) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "dalle3_images", force: :cascade do |t|
    t.string "link"
    t.bigint "post_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_dalle3_images_on_post_id"
  end

  create_table "gpt_creations", force: :cascade do |t|
    t.text "description"
    t.bigint "post_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_gpt_creations_on_post_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string "prompt"
    t.text "description"
    t.string "images_url", default: [], array: true
    t.integer "likes_count", default: 0
    t.integer "comments_count", default: 0
    t.string "status", default: "draft"
    t.datetime "scheduled_at"
    t.datetime "published_at"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "first_name", default: "", null: false
    t.string "last_name", default: "", null: false
    t.string "company", default: "", null: false
    t.string "information", default: ""
    t.string "status", default: "normal"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "instagram", default: "@"
    t.string "thread", default: ""
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "dalle3_images", "posts"
  add_foreign_key "gpt_creations", "posts"
  add_foreign_key "posts", "users"
end
