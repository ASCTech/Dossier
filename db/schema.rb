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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120314201611) do

  create_table "document_tags", :force => true do |t|
    t.integer  "document_id"
    t.integer  "tag_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "document_tags", ["document_id"], :name => "index_document_tags_on_document_id"
  add_index "document_tags", ["tag_id"], :name => "index_document_tags_on_tag_id"

  create_table "documents", :force => true do |t|
    t.integer  "owner_id"
    t.integer  "source_system_id"
    t.integer  "uploader_id"
    t.datetime "created_at",       :null => false
    t.string   "file"
    t.string   "filename"
  end

  add_index "documents", ["owner_id"], :name => "index_documents_on_owner_id"
  add_index "documents", ["source_system_id", "owner_id"], :name => "index_documents_on_source_system_id_and_owner_id"
  add_index "documents", ["source_system_id"], :name => "index_documents_on_source_system_id"

  create_table "source_systems", :force => true do |t|
    t.string   "name"
    t.string   "api_key"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "source_systems", ["api_key"], :name => "index_source_systems_on_api_key"
  add_index "source_systems", ["name"], :name => "index_source_systems_on_name"

  create_table "tags", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "tags", ["name"], :name => "index_tags_on_name"

end
