# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090726122832) do

  create_table "recipients", :force => true do |t|
    t.string  "first_name"
    t.string  "last_name"
    t.integer "address_id"
    t.string  "phone_primary"
    t.string  "phone_secondary"
    t.string  "email"
    t.integer "previous_address_id"
    t.integer "health_care_number"
    t.boolean "status"
    t.integer "case_worker_id"
    t.integer "bedrooms"
    t.integer "number_of_adults"
    t.integer "number_of_children"
    t.string  "comments"
  end

end
