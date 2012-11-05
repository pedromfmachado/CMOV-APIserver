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

ActiveRecord::Schema.define(:version => 20121105110403) do

  create_table "line_stations", :force => true do |t|
    t.integer  "order"
    t.integer  "distance"
    t.integer  "Line_id"
    t.integer  "Station_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "line_stations", ["Line_id"], :name => "index_line_stations_on_Line_id"
  add_index "line_stations", ["Station_id"], :name => "index_line_stations_on_Station_id"

  create_table "lines", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "reservations", :force => true do |t|
    t.string   "uuid"
    t.integer  "User_id"
    t.integer  "Trip_id"
    t.integer  "ArrivalStation_id"
    t.integer  "DepartureStation_id"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  add_index "reservations", ["ArrivalStation_id"], :name => "index_reservations_on_ArrivalStation_id"
  add_index "reservations", ["DepartureStation_id"], :name => "index_reservations_on_DepartureStation_id"
  add_index "reservations", ["Trip_id"], :name => "index_reservations_on_Trip_id"
  add_index "reservations", ["User_id"], :name => "index_reservations_on_User_id"

  create_table "stations", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "trains", :force => true do |t|
    t.integer  "maxCapacity"
    t.float    "velocity"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "trip_types", :force => true do |t|
    t.string   "name"
    t.float    "price"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "trips", :force => true do |t|
    t.datetime "beginTime"
    t.integer  "TripType_id"
    t.integer  "Train_id"
    t.integer  "Line_id"
    t.integer  "ArrivalStation_id"
    t.integer  "DepartureStation_id"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  add_index "trips", ["ArrivalStation_id"], :name => "index_trips_on_ArrivalStation_id"
  add_index "trips", ["DepartureStation_id"], :name => "index_trips_on_DepartureStation_id"
  add_index "trips", ["Line_id"], :name => "index_trips_on_Line_id"
  add_index "trips", ["Train_id"], :name => "index_trips_on_Train_id"
  add_index "trips", ["TripType_id"], :name => "index_trips_on_TripType_id"

  create_table "users", :force => true do |t|
    t.string   "name",                   :default => "",         :null => false
    t.string   "address",                :default => "",         :null => false
    t.string   "role",                   :default => "customer", :null => false
    t.string   "cctype",                 :default => "",         :null => false
    t.string   "ccnumber",               :default => "",         :null => false
    t.date     "ccvalidity",                                     :null => false
    t.string   "email",                  :default => "",         :null => false
    t.string   "encrypted_password",     :default => "",         :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                     :null => false
    t.datetime "updated_at",                                     :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
