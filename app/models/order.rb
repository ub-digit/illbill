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

  def title
    json_hash['ill_requests'][0]['title']
    rescue
      return ""
  end

  def processing_time
    json_hash['ill_requests'][0]['processing_time']
    rescue
      return ""
  end

  def as_json (opts = {})

    return super.merge({
      receiving_library_code: receiving_library_code,
      receiving_library_name: receiving_library_name
      })

  end

end
