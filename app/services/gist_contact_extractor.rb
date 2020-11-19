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
    if ruby_res['contacts'].empty?
      no_contacts_error
    else
      json_contact_list ruby_res
    end
  end

  def self.parse_contact(json)
    ruby_res = MultiJson.load(json)
    tmp = ruby_res
    unless ruby_res['errors']
      tmp = ruby_res['contact'].select do |k, _v|
        KEYS_TO_EXTRACT.include? k
      end
    end
    MultiJson.dump(tmp)
  end
end

private

def json_contact_list(ruby_response)
  tmp = []
  ruby_response['contacts'].each do |contact|
    tmp2 = contact.select do |k, _v|
      KEYS_TO_EXTRACT_LIST.include? k
    end
    tmp << tmp2
  end
  @json_template['contacts'] = tmp
  MultiJson.dump(@json_template)
end

def no_contacts_error
  @error_template['error_code'] = 204
  @error_template['error_message'] = 'No contacts found'
  MultiJson.dump(@error_template)
end
