# frozen_string_literal: true

class GistContactExtractor
  KEYS_TO_EXTRACT = %w[id phone_number first_name last_name job_title company_name mobile_phone_number avatar].freeze
  @json_list_template = {
    contacts: nil,
    next_page: nil,
    last_page: nil
  }
  @error_template = {
    error_code: nil,
    error_message: nil
  }
  @error_codes = {
    parameter_missing: [204, 'Contact identifier missing'],
    not_present: [400, 'Contact email missing'],
    not_found: [204, 'No contact with given id found'],
    internal_error: [500, 'Internal server error']
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
      choose_error_message ruby_res['errors'][0]
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
      self::KEYS_TO_EXTRACT.include? k
    end
    tmp << tmp2
  end
  prepare_response ruby_response['pages'], tmp
  MultiJson.dump(@json_list_template)
end

def json_contact(ruby_response)
  tmp = ruby_response['contact'].select do |k, _v|
    self::KEYS_TO_EXTRACT.include? k
  end
  MultiJson.dump(tmp)
end

def prepare_response(ruby_response, tmp)
  if ruby_response['next']
    @json_list_template['next_page'] = Rack::Utils.parse_query(URI(ruby_response['next']).query)['page']
    @json_list_template['last_page'] = Rack::Utils.parse_query(URI(ruby_response['last']).query)['page']
  end
  @json_list_template['contacts'] = tmp
end

def choose_error_message(errors)
  tmp = errors['code'].to_sym
  @error_template['error_code'] = @error_codes[tmp][0]
  @error_template['error_message'] = @error_codes[tmp][1]
  MultiJson.dump(@error_template)
end

def no_contacts_error
  @error_template['error_code'] = 204
  @error_template['error_message'] = 'No contacts found'
  MultiJson.dump(@error_template)
end
