THXLWeChat::Application.routes.draw do

  root :to => 'home#index'

  resource :wechat, only:[:show, :create]

  resources :cars, only:[:index, :show] do
    member do
      get :detail
    end
  end

  get '/contact/show', 'contact#show'

  get '/tool/bx_cal', 'tool#bx_cal'
  get '/tool/dk_cal', 'tool#dk_cal'
  get '/tool/qk_cal', 'tool#qk_cal'
  get '/tool/weizhang', 'tool#weizhang'
  post '/tool/weizhang_result', 'tool#weizhang_result'

end
