class V1::SigelsController < ApplicationController
  def index
    sigels = Order.pluck(:sigel).uniq.compact
    render json: {sigels: sigels}, status: 200
  end
end
