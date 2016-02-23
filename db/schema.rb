# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160223111859) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authors", force: :cascade do |t|
    t.text     "image_url"
    t.text     "bio_text"
    t.text     "name"
    t.text     "job_title"
    t.text     "job_description"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "pg_search_documents", force: :cascade do |t|
    t.text     "content"
    t.integer  "searchable_id"
    t.string   "searchable_type"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "pg_search_documents", ["searchable_type", "searchable_id"], name: "index_pg_search_documents_on_searchable_type_and_searchable_id", using: :btree

  create_table "recordings", force: :cascade do |t|
    t.integer  "author_id"
    t.integer  "transcript_id"
    t.integer  "timecode_id"
    t.text     "description"
    t.text     "image_url"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.string   "name"
    t.string   "cached_tags"
  end

  create_table "segments", force: :cascade do |t|
    t.integer  "recording_id"
    t.string   "start_time"
    t.string   "end_time"
    t.text     "name"
    t.text     "description"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tag_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "taggings", ["taggable_type", "taggable_id"], name: "index_taggings_on_taggable_type_and_taggable_id", using: :btree

  create_table "tags", force: :cascade do |t|
    t.text     "name"
    t.text     "tag_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "parent_id"
  end

  create_table "timecodes", force: :cascade do |t|
    t.time     "start_time"
    t.time     "end_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transcripts", force: :cascade do |t|
    t.text     "body"
    t.integer  "audio_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
