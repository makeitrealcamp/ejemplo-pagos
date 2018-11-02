class EpaycoController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:result, :confirmation]

  def new
  end

  def create
    @charge = Charge.create!(amount: params[:amount])
  end

  def result
    url = "https://secure.epayco.co/validation/v1/reference/#{params[:ref_payco]}"
    response = HTTParty.get(url)

    parsed = JSON.parse(response.body)
    if parsed["success"]
      @data = parsed["data"]
      @charge = Charge.where(uid: @data["x_id_invoice"]).take
    else
      @error = "No se pudo consultar la información"
    end
  end

  def confirmation
    charge = Charge.where(uid: params[:x_id_invoice]).take
    if charge.nil?
      head :unprocessable_entity
      return
    end

    charge.update!(response_data: params.as_json, error_message: nil)

    if signature == params[:x_signature]
      update_status(charge, params[:x_cod_response])
      head :no_content
    else
      puts "Signature: #{signature}"
      puts "Received signature: #{params[:x_signature]}"
      head :unprocessable_entity
    end
  end

  private
    def signature
      msg = "#{params[:x_cust_id_cliente]}^#{ENV['EPAYCO_SECRET']}^#{params[:x_ref_payco]}^#{params[:x_transaction_id]}^#{params[:x_amount]}^#{params[:x_currency_code]}"
      Digest::SHA256.hexdigest(msg)
    end

    def update_status(charge, status)
      if status == "1"
        charge.paid!
      elsif status == "2" || status == "4"
        charge.update!(status: :rejected, error_message: params[:x_response_reason_text])
      elsif status == "3"
        charge.pending!
      else
        head :unprocessable_entity
        return
      end
    end

    def update_payment_method(charge, payment_method)
      if ["VS", "MC", "DC", "CR", "AM"].include?(payment_method)
        charge.creditcard!
      elsif payment_method == "PSE"
        charge.pse!
      else
        charge.referenced!
      end
    end
end
