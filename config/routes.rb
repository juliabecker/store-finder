Rails.application.routes.draw do
  get 'dealers/index'
  get 'dealers/show'
  root to: 'home#index'
  get '/*path' => 'homepage#index'
end
