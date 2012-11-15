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

ActiveRecord::Schema.define(:version => 20121115191657) do

  create_table "line_stations", :force => true do |t|
    t.integer   "order"
    t.integer   "distance"
    t.integer   "line_id"
    t.integer   "station_id"
    t.timestamp "created_at", :null => false
    t.timestamp "updated_at", :null => false
  end

  add_index "line_stations", ["line_id"], :name => "index_line_stations_on_line_id"
  add_index "line_stations", ["station_id"], :name => "index_line_stations_on_station_id"

  create_table "lines", :force => true do |t|
    t.string    "name"
    t.timestamp "created_at", :null => false
    t.timestamp "updated_at", :null => false
  end

  create_table "reservation_trips", :force => true do |t|
    t.integer   "reservation_id"
    t.integer   "trip_id"
    t.integer   "departureStation_id"
    t.integer   "arrivalStation_id"
    t.timestamp "time"
    t.timestamp "created_at",          :null => false
    t.timestamp "updated_at",          :null => false
  end

  add_index "reservation_trips", ["arrivalStation_id"], :name => "index_reservation_trips_on_arrivalStation_id"
  add_index "reservation_trips", ["departureStation_id"], :name => "index_reservation_trips_on_departureStation_id"
  add_index "reservation_trips", ["reservation_id"], :name => "index_reservation_trips_on_reservation_id"
  add_index "reservation_trips", ["trip_id"], :name => "index_reservation_trips_on_trip_id"

  create_table "reservations", :force => true do |t|
    t.string    "uuid"
    t.integer   "user_id"
    t.integer   "arrivalStation_id"
    t.integer   "departureStation_id"
    t.boolean   "canceled",            :default => false, :null => false
    t.timestamp "created_at",                             :null => false
    t.timestamp "updated_at",                             :null => false
    t.date      "date"
    t.boolean   "paid"
  end

  add_index "reservations", ["arrivalStation_id"], :name => "index_reservations_on_arrivalStation_id"
  add_index "reservations", ["departureStation_id"], :name => "index_reservations_on_departureStation_id"
  add_index "reservations", ["user_id"], :name => "index_reservations_on_user_id"

  create_table "stations", :force => true do |t|
    t.string    "name"
    t.timestamp "created_at", :null => false
    t.timestamp "updated_at", :null => false
  end

  create_table "trains", :force => true do |t|
    t.integer   "maxCapacity"
    t.float     "velocity"
    t.timestamp "created_at",  :null => false
    t.timestamp "updated_at",  :null => false
  end

  create_table "trip_types", :force => true do |t|
    t.string    "name"
    t.float     "price"
    t.timestamp "created_at", :null => false
    t.timestamp "updated_at", :null => false
  end

  create_table "trips", :force => true do |t|
    t.time      "beginTime"
    t.integer   "tripType_id"
    t.integer   "train_id"
    t.integer   "line_id"
    t.integer   "arrivalStation_id"
    t.integer   "departureStation_id"
    t.timestamp "created_at",          :null => false
    t.timestamp "updated_at",          :null => false
  end

  add_index "trips", ["arrivalStation_id"], :name => "index_trips_on_arrivalStation_id"
  add_index "trips", ["departureStation_id"], :name => "index_trips_on_departureStation_id"
  add_index "trips", ["line_id"], :name => "index_trips_on_line_id"
  add_index "trips", ["train_id"], :name => "index_trips_on_train_id"
  add_index "trips", ["tripType_id"], :name => "index_trips_on_tripType_id"

  create_table "users", :force => true do |t|
    t.string    "name",                   :default => "",      :null => false
    t.string    "address",                :default => "",      :null => false
    t.string    "role",                   :default => "guest", :null => false
    t.string    "cctype",                 :default => "",      :null => false
    t.string    "ccnumber",               :default => "",      :null => false
    t.date      "ccvalidity",                                  :null => false
    t.string    "email",                  :default => "",      :null => false
    t.string    "encrypted_password",     :default => "",      :null => false
    t.string    "reset_password_token"
    t.timestamp "reset_password_sent_at"
    t.timestamp "remember_created_at"
    t.integer   "sign_in_count",          :default => 0
    t.timestamp "current_sign_in_at"
    t.timestamp "last_sign_in_at"
    t.string    "current_sign_in_ip"
    t.string    "last_sign_in_ip"
    t.timestamp "created_at",                                  :null => false
    t.timestamp "updated_at",                                  :null => false
    t.string    "authentication_token"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
