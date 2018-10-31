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

    charge.update!(response_data: params.as_json)

    if signature == params[:x_signature]
      if params[:x_cod_response] == "1"
        charge.update!(status: :paid)
      elsif params[:x_cod_response] == "2" || params[:x_cod_response] == "4"
        charge.update!(status: :rejected, error_message: params[:x_response_reason_text])
      elsif params[:x_code_response] == "3"
        charge.update!(status: :pending)
      else
        head :unprocessable_entity
        return
      end
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
end
