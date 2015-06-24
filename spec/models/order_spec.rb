require 'rails_helper'

RSpec.describe Order, type: :model do


  describe 'json_hash' do
    context 'order containing json data' do
      it 'should return a data hash' do
        order = create(:order_with_json)

        expect(order.json_hash['library_code']).to eq('G')
      end
    end
    context 'order not containing json hash' do
      it 'should return an empty hash' do
        #order = Order.create()
        order = create(:order, json: nil)

        expect(order.json_hash).to be_empty
      end
    end
  end

  describe 'receiving_library_code' do
    context 'library code exists' do
      it 'should return a library code' do
        order = create(:order_with_json)

        expect(order.receiving_library_code).to eq('Skfb')
      end
    end
    context 'library code does not exist' do
      it 'should return an empty string' do
        order = create(:order)

        expect(order.receiving_library_code).to be_empty
      end
    end
  end

  describe 'receiving_library_name' do
    context 'library name exists' do
      it 'should return a library name' do
        order = create(:order_with_json)

        expect(order.receiving_library_name).to eq('Skellefteå folkbibliotek')
      end
    end
    context 'library name does not exist' do
      it 'should return an empty string' do
        order = create(:order)

        expect(order.receiving_library_name).to be_empty
      end
    end
  end

end
