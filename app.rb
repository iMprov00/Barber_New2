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
	
	file = File.open("public/user.txt", "a")
	file.write("test")
	file.close

 	erb :visit

end

get '/contacts' do
	
 	erb :contacts

end