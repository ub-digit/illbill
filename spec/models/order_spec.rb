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

  describe 'title' do
    context 'title exists' do
      it 'should return a title' do
        order = create(:order_with_json)

        expect(order.title).to eq('Roslagsbladet : tidning för Östhammar, Öregrund och Norrtelje med omnejd.')
      end
    end
    context 'title does not exist' do
      it 'should return an empty string' do
        order = create(:order)

        expect(order.title).to be_empty
      end
    end
  end

  describe 'processing_time' do
    context 'processing time exists' do
      it 'should return a title' do
        order = create(:order_with_json)

        expect(order.processing_time).to eq('Normal')
      end
    end
    context 'processing time does not exist' do
      it 'should return an empty string' do
        order = create(:order)

        expect(order.processing_time).to be_empty
      end
    end
  end

  describe 'as_json' do
    context 'order contains data' do
      it 'should return a lf-number' do
        order = create(:order, lf_number: 'Skfb-150402-0003')

        expect(order.as_json['lf_number']).to eq('Skfb-150402-0003')
      end
      it 'should return a library code' do
        order = create(:order_with_json)

        expect(order.as_json[:receiving_library_code]).to eq('Skfb')
      end
      it 'should return a library name' do
        order = create(:order_with_json)

        expect(order.as_json[:receiving_library_name]).to eq('Skellefteå folkbibliotek')
      end
      it 'should return a price' do
        order = create(:order, price: 80)

        expect(order.as_json['price']).to be 80
      end
      it 'should return an invoice status' do
        order = create(:order, invoiced: false)

        expect(order.as_json['invoiced']).to be false
      end
    end
  end

end
