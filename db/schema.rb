# frozen_string_literal: true

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

ActiveRecord::Schema.define(version: 20_200_517_183_304) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'authentications', force: :cascade do |t|
    t.integer 'user_id', null: false
    t.string 'provider', null: false
    t.string 'uid', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index %w[provider uid], name: 'index_authentications_on_provider_and_uid'
  end

  create_table 'cards', force: :cascade do |t|
    t.text 'original_text', null: false
    t.text 'translated_text', null: false
    t.datetime 'review_time'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.string 'image_file_name'
    t.string 'image_content_type'
    t.bigint 'image_file_size'
    t.datetime 'image_updated_at'
    t.bigint 'deck_id'
    t.integer 'status', default: 0
    t.integer 'mistake_counter', default: 0
    t.index ['deck_id'], name: 'index_cards_on_deck_id'
  end

  create_table 'decks', force: :cascade do |t|
    t.string 'name', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.bigint 'user_id'
    t.index ['user_id'], name: 'index_decks_on_user_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'email'
    t.string 'crypted_password'
    t.string 'salt'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.string 'locale', default: 'en'
    t.index ['email'], name: 'index_users_on_email', unique: true
  end

  add_foreign_key 'cards', 'decks'
  add_foreign_key 'decks', 'users'
end
