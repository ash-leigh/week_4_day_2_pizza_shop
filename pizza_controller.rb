require('sinatra')
require('sinatra/contrib/all')
require('pry-byebug')
require_relative('./models/pizza')

get '/pizza/new' do
  erb(:new)
end

post '/pizza' do
  #create pizza object
  @pizza = Pizza.new(params)
  @pizza.save()
  erb(:create)
end

get '/pizza' do
  @pizzas = Pizza.all()
  erb (:index)
end

