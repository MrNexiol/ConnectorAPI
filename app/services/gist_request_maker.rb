# frozen_string_literal: true

class GistRequestMaker
  def self.call(id: nil)
    HTTP.headers(Authorization: "Bearer #{ENV['GIST_ACCESS_TOKEN']}",
                 'Content-Type': 'application/json').get("https://api.getgist.com/contacts/#{id}").to_s
  end
end
