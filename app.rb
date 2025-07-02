require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'


get '/' do

	erb :index

end

get '/about' do
	
 	erb :about

end

get '/visit' do
	


 	erb :visit

end

post '/visit' do 

	@username = params[:username].to_s
	@number = params[:number].to_s
	@datetime = params[:datetime].to_s
	@barber = params[:barber].to_s

	input_user = {:username => "Введите имя!", :number => "Укажите ваш телефон для связи!",:datetime => "Вы не указали дату когда придете!", :barber => "Вы не выбрали парикмахера!"}

	input_user.each do |key, values|
		if params[key].to_s.strip.empty?
			@error = input_user[key]
			return erb :visit
		end
	end

	file = File.open("public/user.txt", "a")
	file.write("#{@username}, #{@number}, придет #{@datetime}\n")
	file.close

	@message = "Вы успешно записались!"

	erb :visit

end

get '/contacts' do
	
 	erb :contacts

end