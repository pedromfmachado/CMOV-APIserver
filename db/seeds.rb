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

povoadevarzim = Station.create({ name: 'Póvoa de Varzim' })
viladoconde = Station.create({ name: 'Vila do Conde' })
mindelo = Station.create({ name: 'Mindelo' })
campanha = Station.create({ name: 'Campanha' })

ismai = Station.create({ name: 'ISMAI' })
senhoradahora = Station.create({ name: 'Senhora da Hora' })
campoagosto = Station.create({ name: 'Campo 24 de Agosto' })
dragao = Station.create({ name: 'Estadio do Dragao' })

# Lines
lines = Line.create([{ name: 'Amarela' }, { name: 'Vermelha' } , { name: 'Azul' } ])

# Line_Stations
Line_Station.create({ "order"=>1,"distance"=>5,"Line_id"=>lines.first ,"Stations_id"=>sjoao })
Line_Station.create({ "order"=>2,"distance"=>5,"Line_id"=>lines.first ,"Stations_id"=>ipo })
Line_Station.create({ "order"=>3,"distance"=>5,"Line_id"=>lines.first ,"Stations_id"=>salgueiros })
Line_Station.create({ "order"=>4,"distance"=>5,"Line_id"=>lines.first ,"Stations_id"=>trindade })
Line_Station.create({ "order"=>5,"distance"=>5,"Line_id"=>lines.first ,"Stations_id"=>joaodeus })

Line_Station.create({ "order"=>1,"distance"=>5,"Line_id"=>lines.second ,"Stations_id"=>povoadevarzim })
Line_Station.create({ "order"=>2,"distance"=>5,"Line_id"=>lines.second ,"Stations_id"=>viladoconde })
Line_Station.create({ "order"=>3,"distance"=>5,"Line_id"=>lines.second ,"Stations_id"=>mindelo })
Line_Station.create({ "order"=>4,"distance"=>5,"Line_id"=>lines.second ,"Stations_id"=>trindade })
Line_Station.create({ "order"=>5,"distance"=>5,"Line_id"=>lines.second ,"Stations_id"=>campanha })

Line_Station.create({ "order"=>1,"distance"=>5,"Line_id"=>lines.third ,"Stations_id"=>ismai })
Line_Station.create({ "order"=>2,"distance"=>5,"Line_id"=>lines.third ,"Stations_id"=>senhoradahora })
Line_Station.create({ "order"=>3,"distance"=>5,"Line_id"=>lines.third ,"Stations_id"=>trindade })
Line_Station.create({ "order"=>4,"distance"=>5,"Line_id"=>lines.third ,"Stations_id"=>campoagosto })
Line_Station.create({ "order"=>5,"distance"=>5,"Line_id"=>lines.third ,"Stations_id"=>dragao })

# Trains
Train.create({"maxCapacity"=>"10", "velocity"=>60})
Train.create({"maxCapacity"=>"5", "velocity"=>60})
Train.create({"maxCapacity"=>"20", "velocity"=>60})
Train.create({"maxCapacity"=>"2", "velocity"=>60})

# Users
User.create({"name"=>"joao","adress"=>"rua de camoes","role"=>"inspector","email"=>"joao@h.com"})
User.create({"name"=>"jaime","adress"=>"rua das flores","role"=>"customer","cctype"=>"visa","ccnumber"=>"12345","ccvalidity"=>"2014-10-10","email"=>"jaime@h.com"})
User.create({"name"=>"filipe","adress"=>"rua de amorim","role"=>"customer","cctype"=>"americanexpress","ccnumber"=>"11111","ccvalidity"=>"2013-10-10","email"=>"filipe@h.com"})
User.create({"name"=>"fernando","adress"=>"rua monteiro","role"=>"customer","cctype"=>"visa","ccnumber"=>"12315","ccvalidity"=>"2015-10-10","email"=>"fernando@h.com"})
