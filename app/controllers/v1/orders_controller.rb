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


  def create

    order = Order.new(order_params)

    if order.save!
      render json: {order: order}, status: 201
    else
      render json: {error: {msg: 'fel', errors: order.errors}}, status: 422
    end

  end


  def index

    orders = Order.all
    render json: {orders: orders}, status: 200

  end


  def show

    order = Order.find_by_id(params[:id])

    if order
      render json: {order: order}, status: 200
    else
      render json: {error: {msg: 'Hittade ingen order'}}, status: 404
    end

  end


  private
  def order_params
    params.require(:order).permit(:lf_number, :json, :price, :invoiced)
  end

end
