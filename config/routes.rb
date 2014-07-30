THXLWeChat::Application.routes.draw do

  root :to => 'home#index'

  resource :wechat, only:[:show, :create]

  resources :evaluates, only:[:new, :create]

  resources :cars, only:[:index, :show] do
    member do
      get :detail
    end
  end

  get '/order/drive', 'order#drive'
  post '/order/drive_sub', 'order#drive_sub'
  get '/order/care', 'order#care'
  post '/order/care_sub', 'order#care_sub'

  get '/contact/show', 'contact#show'

  get '/tool/bx_cal', 'tool#bx_cal'
  get '/tool/dk_cal', 'tool#dk_cal'
  get '/tool/qk_cal', 'tool#qk_cal'
  get '/tool/weizhang', 'tool#weizhang'
  post '/tool/weizhang_result', 'tool#weizhang_result'
  get '/tool/care', 'tool#care'
  get '/tool/care_edit', 'tool#care_edit'
  post '/tool/care_sub', 'tool#care_sub'

  match '/page/:id' => 'home#page'

  # 后台权限登录控制
  devise_for :admin,
             :controllers => { :sessions => 'admin/sessions' }

  namespace :admin do
    root :to => 'dashboard#show'
  end

end
