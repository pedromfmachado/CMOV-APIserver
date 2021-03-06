# encoding: utf-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Stations
sjoao = Station.create({ name: 'Hospital de Sao Joao' })
ipo = Station.create({ name: 'IPO' })
salgueiros = Station.create({ name: 'Salgueiros' })
trindade = Station.create({ name: 'Trindade' })
joaodeus = Station.create({ name: 'Joao de Deus' })

povoadevarzim = Station.create({ name: 'Povoa de Varzim' })
viladoconde = Station.create({ name: 'Vila do Conde' })
mindelo = Station.create({ name: 'Mindelo' })
campanha = Station.create({ name: 'Campanha' })

ismai = Station.create({ name: 'ISMAI' })
senhoradahora = Station.create({ name: 'Senhora da Hora' })
campoagosto = Station.create({ name: 'Campo 24 de Agosto' })
dragao = Station.create({ name: 'Estadio do Dragao' })

# Lines
lines = Line.create([{ name: 'Amarela' }, { name: 'Vermelha' } , { name: 'Azul' } ])

# LineStations
LineStation.create({ "order"=>1,"distance"=>5,"line_id"=>lines.first.id ,"station_id"=>sjoao.id })
LineStation.create({ "order"=>2,"distance"=>5,"line_id"=>lines.first.id ,"station_id"=>ipo.id })
LineStation.create({ "order"=>3,"distance"=>5,"line_id"=>lines.first.id ,"station_id"=>salgueiros.id })
LineStation.create({ "order"=>4,"distance"=>5,"line_id"=>lines.first.id ,"station_id"=>trindade.id })
LineStation.create({ "order"=>5,"distance"=>5,"line_id"=>lines.first.id ,"station_id"=>joaodeus.id })

LineStation.create({ "order"=>1,"distance"=>5,"line_id"=>lines.second.id ,"station_id"=>povoadevarzim.id })
LineStation.create({ "order"=>2,"distance"=>5,"line_id"=>lines.second.id ,"station_id"=>viladoconde.id })
LineStation.create({ "order"=>3,"distance"=>5,"line_id"=>lines.second.id ,"station_id"=>mindelo.id })
LineStation.create({ "order"=>4,"distance"=>5,"line_id"=>lines.second.id ,"station_id"=>trindade.id })
LineStation.create({ "order"=>5,"distance"=>5,"line_id"=>lines.second.id ,"station_id"=>campanha.id })

LineStation.create({ "order"=>1,"distance"=>5,"line_id"=>lines.third.id ,"station_id"=>ismai.id })
LineStation.create({ "order"=>2,"distance"=>5,"line_id"=>lines.third.id ,"station_id"=>senhoradahora.id })
LineStation.create({ "order"=>3,"distance"=>5,"line_id"=>lines.third.id ,"station_id"=>trindade.id })
LineStation.create({ "order"=>4,"distance"=>5,"line_id"=>lines.third.id ,"station_id"=>campoagosto.id })
LineStation.create({ "order"=>5,"distance"=>5,"line_id"=>lines.third.id ,"station_id"=>dragao.id })

# Trains
train1 = Train.create({"maxCapacity"=>"10", "velocity"=>60.0})
train2 = Train.create({"maxCapacity"=>"5", "velocity"=>60.0})
train3 = Train.create({"maxCapacity"=>"20", "velocity"=>60.0})
train4 = Train.create({"maxCapacity"=>"2", "velocity"=>60.0})

# TripType
local = TripType.create({"name"=>"local", "price"=>0.10})
regional = TripType.create({"name"=>"regional", "price"=>0.15})

# Trips
trip1_12 = Trip.create({"beginTime"=>"12:00", "tripType_id"=>local.id, "train_id"=>train4.id, "line_id"=>lines.first.id, "departureStation_id"=>sjoao.id, "arrivalStation_id"=>joaodeus.id })
trip1_15 = Trip.create({"beginTime"=>"15:00", "tripType_id"=>local.id, "train_id"=>train4.id, "line_id"=>lines.first.id, "departureStation_id"=>sjoao.id, "arrivalStation_id"=>joaodeus.id })
trip1_18 = Trip.create({"beginTime"=>"18:00", "tripType_id"=>local.id, "train_id"=>train4.id, "line_id"=>lines.first.id, "departureStation_id"=>sjoao.id, "arrivalStation_id"=>joaodeus.id })
trip2_12 = Trip.create({"beginTime"=>"12:00", "tripType_id"=>regional.id, "train_id"=>train3.id, "line_id"=>lines.second.id, "departureStation_id"=>povoadevarzim.id, "arrivalStation_id"=>campanha.id })
trip2_15 = Trip.create({"beginTime"=>"15:00", "tripType_id"=>regional.id, "train_id"=>train3.id, "line_id"=>lines.second.id, "departureStation_id"=>povoadevarzim.id, "arrivalStation_id"=>campanha.id })
trip2_18 = Trip.create({"beginTime"=>"18:00", "tripType_id"=>regional.id, "train_id"=>train3.id, "line_id"=>lines.second.id, "departureStation_id"=>povoadevarzim.id, "arrivalStation_id"=>campanha.id })

