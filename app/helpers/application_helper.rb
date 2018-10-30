module ApplicationHelper
  def base_url
    scheme = Rails.env.production? ? "https" : "http"
    "#{scheme}://#{ENV["HOSTNAME"]}"
  end
end
