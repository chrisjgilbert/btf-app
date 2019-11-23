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

ActiveRecord::Schema.define(version: 2019_11_23_125859) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "competitions", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "start_date"
    t.bigint "favourite_id"
    t.date "end_date"
    t.string "location"
    t.string "research_link"
    t.string "previous_winner"
    t.index ["favourite_id"], name: "index_competitions_on_favourite_id"
  end

  create_table "competitors", force: :cascade do |t|
    t.string "name"
    t.bigint "competition_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "points", default: 0
    t.index ["competition_id"], name: "index_competitors_on_competition_id"
  end

  create_table "league_memberships", force: :cascade do |t|
    t.bigint "league_id"
    t.bigint "team_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["league_id"], name: "index_league_memberships_on_league_id"
    t.index ["team_id"], name: "index_league_memberships_on_team_id"
  end

  create_table "leagues", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_leagues_on_user_id"
  end

  create_table "picks", force: :cascade do |t|
    t.bigint "team_id"
    t.bigint "competitor_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["competitor_id"], name: "index_picks_on_competitor_id"
    t.index ["team_id"], name: "index_picks_on_team_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "captain_id"
    t.integer "points", default: 0
    t.index ["captain_id"], name: "index_teams_on_captain_id"
    t.index ["user_id"], name: "index_teams_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "password_reset_digest"
    t.datetime "password_reset_sent_at"
    t.string "activation_digest"
    t.boolean "activated", default: false
    t.datetime "activated_at"
    t.boolean "payment_status", default: false
  end

  add_foreign_key "competitions", "competitors", column: "favourite_id"
  add_foreign_key "competitors", "competitions"
  add_foreign_key "league_memberships", "leagues"
  add_foreign_key "league_memberships", "teams"
  add_foreign_key "leagues", "users"
  add_foreign_key "picks", "competitors"
  add_foreign_key "picks", "teams"
  add_foreign_key "teams", "competitors", column: "captain_id"
  add_foreign_key "teams", "users"
end
