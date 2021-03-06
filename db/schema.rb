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

ActiveRecord::Schema.define(version: 20160229134247) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "entries", force: :cascade do |t|
    t.string   "event_id"
    t.integer  "user_id"
    t.integer  "song_id"
    t.integer  "recording_id"
    t.float    "interest"
    t.float    "engagement"
    t.float    "focus"
    t.float    "relaxation"
    t.float    "instantaneousExcitement"
    t.float    "longTermExcitement"
    t.float    "stress"
    t.integer  "timestamp"
    t.datetime "date"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "signal_quality"
  end

  create_table "profiles", force: :cascade do |t|
    t.date     "birthday"
    t.integer  "gender"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
  end

  create_table "ratings", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "song_id"
    t.integer  "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "recordings", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "song_id"
    t.datetime "date"
    t.integer  "duration"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "songs", force: :cascade do |t|
    t.string   "song_spotify_id"
    t.string   "song_spotify_url"
    t.string   "name"
    t.string   "preview_url"
    t.string   "album_cover_url"
    t.string   "album_name"
    t.integer  "duration"
    t.string   "artist_name"
    t.string   "artist_spotify_id"
    t.string   "echonest_song_type",                     array: true
    t.integer  "echonest_key"
    t.float    "echonest_energy"
    t.float    "echonest_liveness"
    t.float    "echonest_tempo"
    t.float    "echonest_speechiness"
    t.float    "echonest_acousticness"
    t.float    "echonest_instrumentalness"
    t.integer  "echonest_mode"
    t.integer  "echonest_time_signature"
    t.float    "echonest_loudness"
    t.float    "echonest_valence"
    t.float    "echonest_danceability"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "echonest_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "name"
    t.string   "last_name"
    t.string   "country"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
