THXLWeChat::Application.routes.draw do

  root :to => 'home#index'

  resource :wechat, only:[:show, :create]

end
