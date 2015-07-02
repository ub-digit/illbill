require 'rails_helper'

RSpec.describe V1::OrdersController, type: :controller do

  describe 'fetch_order' do

    before :each do

      WebMock.disable_net_connect!

      #valid ID
      stub_request(:get, "http://iller.libris.kb.se/illse/api/illrequests/G/Skfb-150402-0003").
         with(:headers => {'api-key' => 'a4a0437444f147d5d53007b8881edd53'}).
         to_return(:status => 200, :body => File.new("#{Rails.root}/spec/support/mocks/valid_order.json"), :headers => {"Content-Type" => "application/json"})

      #invalid ID
      stub_request(:get, "http://iller.libris.kb.se/illse/api/illrequests/G/Xxxx-150402-0003").
         with(:headers => {'api-key' => 'a4a0437444f147d5d53007b8881edd53'}).
         to_return(:status => 400, :body => File.new("#{Rails.root}/spec/support/mocks/invalid_order.json"), :headers => {"Content-Type" => "application/json"})

    end

    after :each do
      WebMock.allow_net_connect!
    end

    context 'an existing order id' do
      it 'should return an order' do
        get :fetch_order, id: 'Skfb-150402-0003'

        expect(json['order']['ill_requests']).to_not be_empty
      end
      it 'should return a 200 status' do
        get :fetch_order, id: 'Skfb-150402-0003'

        expect(response.status).to eq(200)
      end
    end

    context 'a non-existing id' do
      it 'should not return an order' do
        get :fetch_order, id: 'Xxxx-150402-0003'

        expect(json['order']['ill_requests'].blank?).to be true
      end
      it 'should return a 404 status' do
        get :fetch_order, id: 'Xxxx-150402-0003'

        expect(response.status).to eq(404)
      end
    end


  end

  describe 'create' do
    context 'a valid order object' do
      it 'should return an object' do
        post :create, order: {lf_number: 'Skfb-150402-0003', json: {data: "asfadsfasdf"}.as_json, price: 160, invoiced: false}

        expect(json['order']).to_not be nil
      end
      it 'should return a status 201' do
        post :create, order: {lf_number: 'Skfb-150402-0003', json: {data: "asfadsfasdf"}.as_json, price: 160, invoiced: false}

        expect(response.status).to eq(201)
      end
    end

    context 'with an allready existing lf-number' do
      it 'should return a 422 status' do
        post :create, order: {lf_number: 'Skfb-150402-0003', json: {data: "asfadsfasdf"}.as_json, price: 160, invoiced: false}
        post :create, order: {lf_number: 'Skfb-150402-0003', json: {data: "ewrqwerqw"}.as_json, price: 180, invoiced: false}

        expect(response.status).to eq(422)
      end
    end
  end


  describe 'index' do
    context 'with filter param done' do
      it 'should return a list of done orders' do
        create_list(:done_order, 5)
        create_list(:todo_order, 3)

        get :index, status: 'done'

        expect(json['orders'].count).to be 5
      end
    end

    context 'with filter param done' do
      it 'should return a list of done orders' do
        create_list(:done_order, 3)
        create_list(:todo_order, 5)

        get :index, status: 'todo'

        expect(json['orders'].count).to be 5
      end
    end

    context  'without filter params' do
      it 'should return 17 orders' do
        create_list(:order, 17)

        get :index

        expect(json['orders'].count).to be 17
      end
    end
  end


  describe 'show' do
    context 'order exists' do
      it 'should return an order' do
        order = create(:order)

        get :show, id: order.id

        expect(json['order']).to_not be nil
      end
      it 'should return a status 200' do
        order = create(:order)

        get :show, id: order.id

        expect(response.status).to eq(200)
      end
    end
    context 'order does not exists' do
      it 'should not return an order' do
        get :show, id: 0

        expect(json['order']).to be nil
      end
    end
  end

  describe 'update' do
    context 'update succeeded' do
      it 'should return an order' do
        order = create(:order)

        put :update, id: order.id, order: {invoiced: true}

        expect(json['order']['invoiced']).to be true
      end
      it 'should return a status 200' do
        order = create(:order)

        get :show, id: order.id

        expect(response.status).to eq(200)
      end
    end
  end

  describe 'destroy' do
    context 'destruction succeeded' do
      it 'should return an order' do
        order = create(:order)

        delete :destroy, id: order.id

        expect(json['order']).to_not be nil
      end
      it 'should return a status 200' do
        order = create(:order)

        delete :destroy, id: order.id

        expect(response.status).to eq(200)
      end
    end
  end


end
