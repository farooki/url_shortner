Rails.application.routes.draw do
  root 'url_shortners#index'
  get '/:generated_url' => 'url_shortners#process_a'
  resources :url_shortners, only: %i[index create show new], param: :generated_url


end
