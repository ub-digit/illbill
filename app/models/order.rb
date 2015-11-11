class Order < ActiveRecord::Base
  validates :lf_number, uniqueness: {message: "LF-nummer redan registrerat"}

  def json_hash

    return {} if json.blank? || json == "null"
    @json_hash ||= JSON.parse(json)

  end

  def self.sigel_json json
    hash = JSON.parse(json)
    recipients = hash['ill_requests'][0]['recipients']

    recipient = recipients.select{|item| item["is_active_library"] == true}.first
    recipient["library_code"]
  rescue
    return ""
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

  def receiving_library_department
    json_hash['ill_requests'][0]['receiving_library']['department']
    rescue
      return ""
  end

  def receiving_library_address1
    json_hash['ill_requests'][0]['receiving_library']['address1']
    rescue
      return ""
  end

  def receiving_library_address2
    json_hash['ill_requests'][0]['receiving_library']['address2']
    rescue
      return ""
  end

  def receiving_library_address3
    json_hash['ill_requests'][0]['receiving_library']['address3']
    rescue
      return ""
  end

  def receiving_library_city
    json_hash['ill_requests'][0]['receiving_library']['city']
    rescue
      return ""
  end

  def receiving_library_zip_code
    json_hash['ill_requests'][0]['receiving_library']['zip_code']
    rescue
      return ""
  end

  def title
    json_hash['ill_requests'][0]['title']
    rescue
      return ""
  end

  def user
    json_hash['ill_requests'][0]['user']
    rescue
      return ""
  end

  def isbn_issn
    json_hash['ill_requests'][0]['isbn_issn']
    rescue
      return ""
  end

  def author
    json_hash['ill_requests'][0]['author']
    rescue
      return ""
  end

  def imprint
    json_hash['ill_requests'][0]['imprint']
    rescue
      return ""
  end

  def message
    json_hash['ill_requests'][0]['message']
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
