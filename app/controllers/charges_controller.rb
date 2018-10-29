class ChargesController < ApplicationController
  def index
    @charges = Charge.all
  end
end
