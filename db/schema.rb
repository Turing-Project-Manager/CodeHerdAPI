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

ActiveRecord::Schema.define(version: 2021_08_30_160429) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'collaborators', force: :cascade do |t|
    t.bigint 'user_id'
    t.bigint 'project_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['project_id'], name: 'index_collaborators_on_project_id'
    t.index ['user_id'], name: 'index_collaborators_on_user_id'
  end

  create_table 'project_repos', force: :cascade do |t|
    t.bigint 'project_id'
    t.string 'repo_name'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['project_id'], name: 'index_project_repos_on_project_id'
  end

  create_table 'projects', force: :cascade do |t|
    t.string 'name'
    t.string 'summary'
    t.string 'mod_number'
    t.bigint 'owner_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['owner_id'], name: 'index_projects_on_owner_id'
  end

  create_table 'resources', force: :cascade do |t|
    t.string 'name'
    t.string 'tags', default: [], array: true
    t.bigint 'project_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['project_id'], name: 'index_resources_on_project_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'name'
    t.string 'email'
    t.string 'slack_handle'
    t.string 'github_handle'
    t.string 'working_styles', default: [], array: true
    t.string 'cohort'
    t.string 'pronouns'
    t.string 'github_access_token'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  add_foreign_key 'collaborators', 'projects'
  add_foreign_key 'collaborators', 'users'
  add_foreign_key 'project_repos', 'projects'
  add_foreign_key 'projects', 'users', column: 'owner_id'
  add_foreign_key 'resources', 'projects'
end
