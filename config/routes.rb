Rails.application.routes.draw do
  root "games#start"
  resources :games, only: [:new, :show] do
    resources :pieces, only: [:update] do
      get :legal_moves, on: :member
    end
  end
end
