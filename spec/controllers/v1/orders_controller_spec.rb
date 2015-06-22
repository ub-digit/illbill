require 'rails_helper'

RSpec.describe V1::OrdersController, type: :controller do

  describe 'fetch_order' do

    context 'an existing order id' do
      it 'should return an order' do
        puts response
        get :fetch_order, id: 'Skfb-150402-0003'
        expect(JSON.parse(response.body)['order']['error']).to be nil
        expect(JSON.parse(response.body)['order']['ill_requests'][0]['request_id']).to eq '4946717'
      end
      it 'should return a 200 status' do
        get :fetch_order, id: 'Skfb-150402-0003'
        expect(response.status).to eq 200
      end
    end

    context 'an non-existing id' do
      it 'should return a 404 status' do
        get :fetch_order, id: 'Skfx-150402-0003'

        expect(JSON.parse(response.body)['order']['ill_requests'].blank?).to be true
        expect(response.status).to eq 404

      end
    end


  end
end
