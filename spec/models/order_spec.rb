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

  describe 'sigel_json' do
    context 'json containing sigel' do
      it 'should return a string' do
        data = File.new("#{Rails.root}/spec/support/mocks/order_json_hash.json").read
        sigel = Order.sigel_json(data)
        expect(sigel).to eq "Gk"
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

  describe 'receiving_library_department' do
    context 'library department exists' do
      it 'should return a department' do
        order = create(:order_with_json)

        expect(order.receiving_library_department).to eq('Stadsbiblioteket')
      end
    end
    context 'library city does not exist' do
      it 'should return an empty string' do
        order = create(:order)

        expect(order.receiving_library_department).to be_empty
      end
    end
  end

  describe 'receiving_library_address1' do
    context 'library address 1 exists' do
      it 'should return an address' do
        order = create(:order_with_json)

        expect(order.receiving_library_address1).to eq('Box 703')
      end
    end
    context 'library address 1 does not exist' do
      it 'should return an empty string' do
        order = create(:order)

        expect(order.receiving_library_address1).to be_empty
      end
    end
  end

  describe 'receiving_library_address2' do
    context 'library address 2 exists' do
      it 'should return an address' do
        order = create(:order_with_json)

        expect(order.receiving_library_address2).to eq('Address 2')
      end
    end
    context 'library address 2 does not exist' do
      it 'should return an empty string' do
        order = create(:order)

        expect(order.receiving_library_address2).to be_empty
      end
    end
  end

  describe 'receiving_library_address3' do
    context 'library address 3 exists' do
      it 'should return an address' do
        order = create(:order_with_json)

        expect(order.receiving_library_address3).to eq('Address 3')
      end
    end
    context 'library address 3 does not exist' do
      it 'should return an empty string' do
        order = create(:order)

        expect(order.receiving_library_address3).to be_empty
      end
    end
  end

  describe 'receiving_library_city' do
    context 'library city exists' do
      it 'should return a city' do
        order = create(:order_with_json)

        expect(order.receiving_library_city).to eq('Skellefteå')
      end
    end
    context 'library city does not exist' do
      it 'should return an empty string' do
        order = create(:order)

        expect(order.receiving_library_city).to be_empty
      end
    end
  end

  describe 'receiving_library_zip_code' do
    context 'library zip code exists' do
      it 'should return a zip code' do
        order = create(:order_with_json)

        expect(order.receiving_library_zip_code).to eq('931 27')
      end
    end
    context 'library city does not exist' do
      it 'should return an empty string' do
        order = create(:order)

        expect(order.receiving_library_zip_code).to be_empty
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

  describe 'lf_number' do
    it 'it should be unique' do
      order1 = create(:order, lf_number: 'Skfb-150402-0003')
      order2 = build(:order, lf_number: 'Skfb-150402-0003')

      expect(order2.valid?).to be_falsey
      expect(order2.errors.messages[:lf_number]).to_not be_empty
      expect(order2.errors.messages[:lf_number]).to include('LF-nummer redan registrerat')
    end
  end

end
