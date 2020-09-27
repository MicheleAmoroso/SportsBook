# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_09_25_170328) do

  create_table "books", force: :cascade do |t|
    t.integer "ground_id"
    t.integer "timetable_id"
    t.integer "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["ground_id"], name: "index_books_on_ground_id"
    t.index ["timetable_id"], name: "index_books_on_timetable_id"
    t.index ["user_id"], name: "index_books_on_user_id"
  end

  create_table "grounds", force: :cascade do |t|
    t.string "title"
    t.integer "price"
    t.integer "rating"
    t.string "city"
    t.string "address"
    t.text "description"
    t.string "image", default: "default.jpg"
    t.string "category"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "rating"
    t.text "comments"
    t.integer "user_id"
    t.integer "ground_id"
    t.index ["ground_id"], name: "index_reviews_on_ground_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "timetables", force: :cascade do |t|
    t.string "day"
    t.integer "from"
    t.integer "to"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "provider"
    t.string "uid"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
