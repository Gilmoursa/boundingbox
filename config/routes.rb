Rails.application.routes.draw do
  namespace :api, :defaults => {:format => :json} do
    namespace :v1 do
      get '/aspect', to: 'aspect#format_bounding_box'
    end
  end
end
