# frozen_string_literal: true

class ContactsController < ApplicationController
  def index
    tmp = GistRequestMaker.call
    render json: GistContactExtractor.parse_contact_list(tmp)
  end

  def show
    tmp = GistRequestMaker.call(id: params[:id])
    render json: GistContactExtractor.parse_contact(tmp)
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
