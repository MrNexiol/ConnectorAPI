# frozen_string_literal: true

class GistRequestMaker
  def self.get(id: nil, per_page: 50, page: 1)
    HTTP.headers(Authorization: "Bearer #{ENV['GIST_ACCESS_TOKEN']}",
                 'Content-Type': 'application/json').get("https://api.getgist.com/contacts/#{id}",
                                                         params: { per_page: per_page, page: page }).to_s
  end

  def self.delete(id:)
    HTTP.headers(Authorization: "Bearer #{ENV['GIST_ACCESS_TOKEN']}",
                 'Content-Type': 'application/json').delete("https://api.getgist.com/contacts/#{id}").to_s
  end

  def self.post(params: nil)
    HTTP
      .headers(Authorization: "Bearer #{ENV['GIST_ACCESS_TOKEN']}", 'Content-Type': 'application/json')
      .post('https://api.getgist.com/contacts',
            json: {
              email: params[:email],
              user_id: params[:user_id],
              first_name: params[:first_name],
              last_name: params[:last_name],
              phone_number: params[:phone_number],
              job_title: params[:job_title],
              company_name: params[:company_name],
              mobile_phone_number: params[:mobile_phone_number],
              avatar: params[:avatar]
            })
      .to_s
  end
end
