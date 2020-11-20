# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Contacts', type: :request do
  context 'index action' do
    it 'renders contact list' do
      get contacts_path
      res = MultiJson.load(response.body)
      expect(res['contacts']).not_to be_empty
    end

    it 'renders contacts list with specified number of contacts' do
      get contacts_path(params: { per_page: 1 })
      res = MultiJson.load(response.body)
      expect(res['contacts'].length).to eql 1
    end
  end

  context 'show action' do
    let!(:correct_id) { 212_312_933 }
    let!(:unused_id) { 1 }
    let!(:wrong_type_id) { 'asd' }

    it 'renders error on unused id' do
      get contact_path(unused_id)
      res = MultiJson.load(response.body)
      expect(res['error_message']).to eql 'No contact with given id found'
    end

    it 'renders error on wrong type id' do
      get contact_path(wrong_type_id)
      res = MultiJson.load(response.body)
      expect(res['error_message']).to eql 'No contact with given id found'
    end

    it 'renders contact data when id found' do
      get contact_path(correct_id)
      res = MultiJson.load(response.body)
      expect(res).to include 'company_name'
    end
  end
end
