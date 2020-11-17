# frozen_string_literal: true

class GistContactExtractor
  KEYS_TO_EXTRACT = %w[id phone_number first_name last_name job_title mobile_phone_number avatar].freeze
  @json_template = {
    'contacts': nil,
    next_page_token: nil,
    next_sync_token: nil
  }

  def self.call(json)
    ruby_res = MultiJson.load(json)
    tmp = []
    ruby_res['contacts'].each do |contact|
      tmp2 = contact.select do |k, _v|
        KEYS_TO_EXTRACT.include? k
      end
      tmp << tmp2
    end
    @json_template['contacts'] = tmp
    MultiJson.dump(@json_template)
  end
end
