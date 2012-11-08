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
LineStation.create({ "order"=>1,"distance"=>5,"Line_id"=>lines.first ,"Station_id"=>sjoao })
LineStation.create({ "order"=>2,"distance"=>5,"Line_id"=>lines.first ,"Station_id"=>ipo })
LineStation.create({ "order"=>3,"distance"=>5,"Line_id"=>lines.first ,"Station_id"=>salgueiros })
LineStation.create({ "order"=>4,"distance"=>5,"Line_id"=>lines.first ,"Station_id"=>trindade })
LineStation.create({ "order"=>5,"distance"=>5,"Line_id"=>lines.first ,"Station_id"=>joaodeus })

LineStation.create({ "order"=>1,"distance"=>5,"Line_id"=>lines.second ,"Station_id"=>povoadevarzim })
LineStation.create({ "order"=>2,"distance"=>5,"Line_id"=>lines.second ,"Station_id"=>viladoconde })
LineStation.create({ "order"=>3,"distance"=>5,"Line_id"=>lines.second ,"Station_id"=>mindelo })
LineStation.create({ "order"=>4,"distance"=>5,"Line_id"=>lines.second ,"Station_id"=>trindade })
LineStation.create({ "order"=>5,"distance"=>5,"Line_id"=>lines.second ,"Station_id"=>campanha })

LineStation.create({ "order"=>1,"distance"=>5,"Line_id"=>lines.third ,"Station_id"=>ismai })
LineStation.create({ "order"=>2,"distance"=>5,"Line_id"=>lines.third ,"Station_id"=>senhoradahora })
LineStation.create({ "order"=>3,"distance"=>5,"Line_id"=>lines.third ,"Station_id"=>trindade })
LineStation.create({ "order"=>4,"distance"=>5,"Line_id"=>lines.third ,"Station_id"=>campoagosto })
LineStation.create({ "order"=>5,"distance"=>5,"Line_id"=>lines.third ,"Station_id"=>dragao })

# Trains
Train.create({"maxCapacity"=>"10", "velocity"=>60})
Train.create({"maxCapacity"=>"5", "velocity"=>60})
Train.create({"maxCapacity"=>"20", "velocity"=>60})
Train.create({"maxCapacity"=>"2", "velocity"=>60})

# Users
User.create({"name"=>"joao","address"=>"rua de camoes","role"=>"inspector","email"=>"joao@h.com"})
User.create({"name"=>"jaime","address"=>"rua das flores","role"=>"customer","cctype"=>"visa","ccnumber"=>"12345","ccvalidity"=>"2014-10-10","email"=>"jaime@h.com"})
User.create({"name"=>"filipe","address"=>"rua de amorim","role"=>"customer","cctype"=>"americanexpress","ccnumber"=>"11111","ccvalidity"=>"2013-10-10","email"=>"filipe@h.com"})
User.create({"name"=>"fernando","address"=>"rua monteiro","role"=>"customer","cctype"=>"visa","ccnumber"=>"12315","ccvalidity"=>"2015-10-10","email"=>"fernando@h.com"})
