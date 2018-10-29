module PayuHelper
  def payu_url
    # if Rails.env.production?
    #   "https://checkout.payulatam.com/ppp-web-gateway-payu"
    # else
      "https://sandbox.checkout.payulatam.com/ppp-web-gateway-payu/"
    #end
  end
end
