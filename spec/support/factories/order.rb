FactoryGirl.define do
  factory :order do
    #step {generate :step}
    #association :job, factory: [:job]
    #process "CONFIRMATION"
    #description "Test confirmation flow step"
    #params "{\"manual\":true}"    

    trait :has_json do
      json JSON.parse(File.new("#{Rails.root}/spec/support/mocks/order_json_hash.json").read).to_json
    end

    factory :order_with_json, traits: [:has_json]

  end

end
