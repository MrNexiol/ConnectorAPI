# frozen_string_literal: true

class ContactsController < ApplicationController
  def index
    tmp = HTTP.headers(Authorization: "Bearer #{ENV['GIST_ACCESS_TOKEN']}",
                       'Content-Type': 'application/json').get('https://api.getgist.com/contacts').to_s
    res = GistContactExtractor.call(tmp)
    render json: res
  end

  def show
    render json: 'Show action'
  end

  def create
    render json: 'Create action'
  end

  def update
    render json: 'Update action'
  end

  def destroy
    render json: 'Delete action'
  end
end
