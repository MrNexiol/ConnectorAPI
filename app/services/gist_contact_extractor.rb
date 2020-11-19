# frozen_string_literal: true

class GistContactExtractor
  KEYS_TO_EXTRACT_LIST = %w[id full_name job_title company_name avatar].freeze
  KEYS_TO_EXTRACT = %w[id phone_number first_name last_name job_title company_name mobile_phone_number avatar].freeze
  @json_template = {
    contacts: nil,
    next_page_token: nil,
    next_sync_token: nil
  }
  @error_template = {
    error_code: nil,
    error_message: nil
  }

  def self.parse_contact_list(json)
    ruby_res = MultiJson.load(json)
    if ruby_res.key? 'errors'
      no_contacts_error
    else
      json_contact_list ruby_res
    end
  end

  def self.parse_contact(json)
    ruby_res = MultiJson.load(json)
    if ruby_res.key? 'errors'
      no_contact_error
    else
      json_contact ruby_res
    end
  end
end

private

def json_contact_list(ruby_response)
  tmp = []
  ruby_response['contacts'].each do |contact|
    tmp2 = contact.select do |k, _v|
      self::KEYS_TO_EXTRACT_LIST.include? k
    end
    tmp << tmp2
  end
  @json_template['contacts'] = tmp
  MultiJson.dump(@json_template)
end

def json_contact(ruby_response)
  tmp = ruby_response['contact'].select do |k, _v|
    self::KEYS_TO_EXTRACT.include? k
  end
  MultiJson.dump(tmp)
end

def no_contacts_error
  @error_template['error_code'] = 204
  @error_template['error_message'] = 'No contacts found'
  MultiJson.dump(@error_template)
end

def no_contact_error
  @error_template['error_code'] = 204
  @error_template['error_message'] = 'No contact with given id found'
  MultiJson.dump(@error_template)
end
