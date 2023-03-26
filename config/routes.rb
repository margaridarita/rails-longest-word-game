Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'games#new'
  post '/score', to: 'games#score'
  get '/score', to: 'games#new'
end
