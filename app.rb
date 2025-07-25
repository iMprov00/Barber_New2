require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'

configure do 

	db = SQLite3::Database.new 'barbershop.db'
	db.execute 'CREATE TABLE IF NOT EXISTS
	"Users"
	(
		"id" INTEGER PRIMARY KEY AUTOINCREMENT,
		"username" TEXT,
		"phone" TEXT,
		"datestamp" TEXT,
		"barber" TEXT,
		"color" TEXT
	)'

		db.execute 'CREATE TABLE IF NOT EXISTS
	"Barber"
	(
		"barber" TEXT
	)'

end



get '/' do

	erb :index

end

get '/about' do
	
 	erb :about

end

get '/visit' do
	
	db = SQLite3::Database.new 'barbershop.db'

	db.results_as_hash = true

	@barbers = []

	db.execute 'select * from Barber' do |row|

		@barbers << row['barber']

	end

 	erb :visit

end

post '/visit' do 

	@username = params[:username].to_s
	@number = params[:number].to_s
	@datetime = params[:datetime].to_s
	@barber = params[:barber].to_s
	@color = params[:color]

	input_user = {:username => "Введите имя!", :number => "Укажите ваш телефон для связи!",:datetime => "Вы не указали дату когда придете!", :barber => "Вы не выбрали парикмахера!"}

	input_user.each do |key, values|
		if params[key].to_s.strip.empty?
			@error = input_user[key]
			return erb :visit
		end
	end

	file = File.open("public/user.txt", "a")
	file.write("#{@username}, #{@number}, придет #{@datetime}, цвет краски #{@color}\n")
	file.close
	
	db = SQLite3::Database.new 'barbershop.db'
	db.execute 'insert into

		Users (
			username,
			phone,
			datestamp,
			barber,
			color
		)
		values 
		(
			?, ?, ?, ?, ?
		)', [@username, @number, @datetime, @barber, @color]

	@message = "Вы успешно записались!"

	erb :visit

end

get '/contacts' do
	
 	erb :contacts

end

get '/showusers' do 

	db = SQLite3::Database.new 'barbershop.db'
	db.results_as_hash = true

	@result = []

	@result = db.execute 'select * from Users'

	erb :showusers

end
