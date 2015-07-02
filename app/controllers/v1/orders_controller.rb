require 'httparty'

class V1::OrdersController < ApplicationController

  def fetch_order
    id=params[:id]

    headers = {'api-key' => 'a4a0437444f147d5d53007b8881edd53'}

    response = HTTParty.get('http://iller.libris.kb.se/illse/api/illrequests/G/' + id, :headers => headers)

    if response['ill_requests'].blank?
      render json: {order: response}, status: 404
      return
    end

    render json: {order: response}, status: 200

  end


  def create

    params[:order][:json] = params[:order][:json].to_json
    order = Order.new(order_params)

    if order.save
      render json: {order: order}, status: 201
    else

      render json: {error: {msg: 'Ordern kunde inte sparas', errors: order.errors}}, status: 422
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

    if order.update_attributes(order_update_params)
      render json: {order: order}, status: 200
    else
      render json: {error: {msg: 'fel', errors: order.errors}}, status: 422
    end

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
      format.pdf { send_data InvoiceData.create_pdf(@orders), :filename => "pdf.pdf", type: "application/pdf", disposition: "inline" }
    end


  end


  private
  def order_params
    params.require(:order).permit(:lf_number, :json, :price, :invoiced)
  end

  def order_update_params
    params.require(:order).permit(:lf_number, :price, :invoiced)
  end

end
