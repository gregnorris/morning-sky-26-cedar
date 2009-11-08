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

ActiveRecord::Schema.define(:version => 20091101104352) do

  create_table "delivered_items", :force => true do |t|
    t.integer  "delivery_id"
    t.integer  "item_id"
    t.integer  "number_requested"
    t.integer  "number_delivered"
    t.string   "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "deliveries", :force => true do |t|
    t.integer  "recipient_id"
    t.datetime "call_recieved_at"
    t.datetime "scheduled_delivery_time"
    t.datetime "visited_on_1"
    t.datetime "visited_on_2"
    t.datetime "delivered_on"
    t.string   "initialed_by"
    t.string   "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "donor_items", :force => true do |t|
    t.integer  "donor_id"
    t.integer  "item_id"
    t.integer  "number_donated"
    t.date     "donated_on"
    t.string   "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "donors", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone_primary"
    t.string   "phone_secondary"
    t.integer  "donation_amount",             :limit => 10, :precision => 10, :scale => 0
    t.integer  "city_section"
    t.string   "street_1"
    t.string   "street_2"
    t.integer  "level"
    t.integer  "buzzer_number"
    t.boolean  "elevator"
    t.string   "directions"
    t.datetime "scheduled_pickup_time"
    t.datetime "possible_future_pickup_time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
  end

  create_table "items", :force => true do |t|
    t.string   "item_code"
    t.string   "name"
    t.string   "description"
    t.string   "icon_path"
    t.string   "image_path"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "recipients", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "address_id"
    t.string   "phone_primary"
    t.string   "phone_secondary"
    t.string   "email"
    t.integer  "previous_address_id"
    t.integer  "health_care_number"
    t.boolean  "status"
    t.integer  "case_worker_id"
    t.integer  "bedrooms"
    t.integer  "number_of_adults"
    t.integer  "number_of_children"
    t.string   "comments"
    t.integer  "city_section"
    t.string   "street_1"
    t.string   "street_2"
    t.integer  "level"
    t.integer  "buzzer_number"
    t.boolean  "elevator"
    t.string   "directions"
    t.date     "move_in_date"
    t.string   "previous_address"
    t.string   "work_school_schedule"
    t.integer  "donation",                :limit => 10, :precision => 10, :scale => 0
    t.string   "additional_information"
    t.date     "intake_date"
    t.string   "referred_by"
    t.datetime "next_scheduled_delivery"
  end

end
