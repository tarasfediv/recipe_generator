Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post '/recipes', to: 'recipes#create'
    end
  end
end