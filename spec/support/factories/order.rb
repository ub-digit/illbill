FactoryGirl.define do

  sequence :lf_number do |n|
    "Skfb-150402-000#{n}"
  end


  factory :order do

    lf_number

    #step {generate :step}
    #association :job, factory: [:job]
    #process "CONFIRMATION"
    #description "Test confirmation flow step"
    #params "{\"manual\":true}"

    trait :has_json do
      json JSON.parse(File.new("#{Rails.root}/spec/support/mocks/order_json_hash.json").read).to_json
    end

    trait :invoiced do
      invoiced true
    end

    trait :not_invoiced do
      invoiced false
    end

    factory :order_with_json, traits: [:has_json]

    factory :done_order, traits: [:invoiced]

    factory :todo_order, traits: [:not_invoiced]

  end

end
