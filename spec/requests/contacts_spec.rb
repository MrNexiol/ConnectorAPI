# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Contacts', type: :request do
  context 'tests' do
    it 'requests contact list' do
      get contacts_path
      expect(response.body).to include 'contacts'
    end

    it 'should render single contact' do
      get '/contacts/1'
      res = MultiJson.load(response.body)
      expect(res['errors'][0]['message']).to eql "Couldn't find Contacts"
    end
  end
end
