Rails.application.routes.draw do
  root "charges#index"

  get  "/payu", to: "payu#new"
  post "/payu", to: "payu#create"
  get  "/payu/response", to: "payu#result"
  post "/payu/confirmation", to: "payu#confirmation"

  get "/epayco", to: "epayco#new"
  post "/epayco", to: "epayco#create"
  get "/epayco/response", to: "epayco#result"
  post "/epayco/response", to: "epayco#result"
  post "/epayco/confirmation", to: "epayco#confirmation"
end
