class Order < ActiveRecord::Base

  def json_hash

    return {} if json.blank? || json == "null"
    @json_hash ||= JSON.parse(json)

  end

  def receiving_library_code
    json_hash['ill_requests'][0]['receiving_library']['library_code']
    rescue
      return ""
  end

  def receiving_library_name
    json_hash['ill_requests'][0]['receiving_library']['name']
    rescue
      return ""
  end
end
