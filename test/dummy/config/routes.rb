Rails.application.routes.draw do

  mount FcApi::Engine => "/fc_api"
end
