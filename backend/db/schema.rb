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

ActiveRecord::Schema[7.0].define(version: 2024_10_09_192427) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "actions", force: :cascade do |t|
    t.bigint "match_id", null: false
    t.bigint "player_id", null: false
    t.string "action_type"
    t.time "timestamp"
    t.string "section"
    t.integer "quarter"
    t.bigint "assisted_by_player_id"
    t.bigint "fouled_player_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "team_id", default: 1, null: false
    t.index ["assisted_by_player_id"], name: "index_actions_on_assisted_by_player_id"
    t.index ["fouled_player_id"], name: "index_actions_on_fouled_player_id"
    t.index ["match_id"], name: "index_actions_on_match_id"
    t.index ["player_id"], name: "index_actions_on_player_id"
    t.index ["team_id"], name: "index_actions_on_team_id"
  end

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

  create_table "matches", force: :cascade do |t|
    t.bigint "home_team_id", null: false
    t.bigint "away_team_id", null: false
    t.datetime "date", null: false
    t.string "youtube_link", null: false
    t.bigint "technical_manager_id", null: false
    t.bigint "anotador_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["anotador_id"], name: "index_matches_on_anotador_id"
    t.index ["away_team_id"], name: "index_matches_on_away_team_id"
    t.index ["home_team_id"], name: "index_matches_on_home_team_id"
    t.index ["technical_manager_id"], name: "index_matches_on_technical_manager_id"
  end

  create_table "player_match_stats", force: :cascade do |t|
    t.bigint "match_id", null: false
    t.bigint "player_id", null: false
    t.integer "points"
    t.integer "field_goals_made"
    t.integer "field_goals_attempted"
    t.integer "free_throws_made"
    t.integer "free_throws_attempted"
    t.integer "three_points_made"
    t.integer "three_points_attempted"
    t.integer "rebounds_offensive"
    t.integer "rebounds_defensive"
    t.integer "assists"
    t.integer "steals"
    t.integer "blocks"
    t.integer "turnovers"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["match_id"], name: "index_player_match_stats_on_match_id"
    t.index ["player_id"], name: "index_player_match_stats_on_player_id"
  end

  create_table "players", force: :cascade do |t|
    t.string "name"
    t.bigint "team_id", null: false
    t.string "position"
    t.integer "number"
    t.float "height"
    t.float "weight"
    t.float "wingspan"
    t.float "vertical_jump"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id"], name: "index_players_on_team_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.string "logo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_teams_on_name", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "player_id"
    t.string "name"
    t.integer "role"
    t.string "avatar"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["player_id"], name: "index_users_on_player_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "actions", "matches"
  add_foreign_key "actions", "players"
  add_foreign_key "actions", "players", column: "assisted_by_player_id"
  add_foreign_key "actions", "players", column: "fouled_player_id"
  add_foreign_key "actions", "teams"
  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "matches", "teams", column: "away_team_id"
  add_foreign_key "matches", "teams", column: "home_team_id"
  add_foreign_key "matches", "users", column: "anotador_id"
  add_foreign_key "matches", "users", column: "technical_manager_id"
  add_foreign_key "player_match_stats", "matches"
  add_foreign_key "player_match_stats", "players"
  add_foreign_key "players", "teams"
  add_foreign_key "users", "players"
end
