require 'httparty'
class V1::OrdersController < ApplicationController
  def fetch_order
    id=params[:id]
    response = HTTParty.get('http://iller.libris.kb.se/illse/api/illrequests/G/' + id)

    if response['ill_requests'].blank?
      render json: {order: response}, status: 404
      return
    end

    render json: {order: response}, status: 200

  end
end
