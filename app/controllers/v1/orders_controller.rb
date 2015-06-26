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

    params[:order][:json] = params[:order][:json].to_json
    order = Order.new(order_params)

    if order.save!
      render json: {order: order}, status: 201
    else
      render json: {error: {msg: 'fel', errors: order.errors}}, status: 422
    end

  end


  def index

    if params[:status].present? && params[:status] == 'done'
      orders = Order.where(invoiced: true).order('lf_number ASC')
    elsif params[:status].present? && params[:status] == 'todo'
      orders = Order.where(invoiced: false).order('lf_number ASC')
    else
      orders = Order.all.order('lf_number ASC')
    end

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


  def update

    if params[:order][:json].present?
      params[:order][:json] = params[:order][:json].to_json
    end

    order = Order.find_by_id(params[:id])

    if order.update_attributes(order_params)
      render json: {order: order}, status: 200
    else
      render json: {error: {msg: 'fel', errors: order.errors}}, status: 422
    end

  end


  def update_many

    #orders = Order.where(id: params[:ids])

    # gör json-magi

    #params[:orders]

    #orders.update


  end


  def destroy
    order = Order.find_by_id(params[:id])

    if order.destroy
      render json: {order: order}, status: 200
    else
      render json: {error: {msg: 'Hittade ingen order'}}, status: 422
    end
  end


  def invoice_data
    @orders = Order.where(id: params[:ids])

    respond_to do |format|
      format.html {render 'v1/orders/invoice_data'}
    end


  end


  private
  def order_params
    params.require(:order).permit(:lf_number, :json, :price, :invoiced)
  end

end
