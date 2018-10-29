Rails.application.routes.draw do
  root "charges#index"

  get  "/payu", to: "payu#new"
  post "/payu", to: "payu#create"
  get  "/payu/response", to: "payu#result"
  post "/payu/confirmation", to: "payu#confirmation"
end
