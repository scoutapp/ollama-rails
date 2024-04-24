Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "ollamaai#index"
  #get '/', to: 'ollamaai#index'
  get '/generate', to: 'ollamaai#generate'
  get '/chat', to: 'ollamaai#chat'
  get '/embeddings', to: 'ollamaai#embeddings'
  get '/model/create', to: 'ollamaai#model_create'
  get '/model/show', to: 'ollamaai#model_show'
  get '/model/use/:name', to: 'ollamaai#model_use'
  get '/image', to: 'ollamaai#image'

end
