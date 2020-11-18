# frozen_string_literal: true

class ContactsController < ApplicationController
  def index
    tmp = GistRequestMaker.get
    render json: GistContactExtractor.parse_contact_list(tmp)
  end

  def show
    tmp = GistRequestMaker.get(id: params[:id])
    render json: GistContactExtractor.parse_contact(tmp)
  end

  def create
    tmp = GistRequestMaker.post(params: params)
    render json: GistContactExtractor.parse_contact(tmp)
  end

  def update
    render json: 'Update action'
  end

  def destroy
    tmp = GistRequestMaker.delete(id: params[:id])
    render json: GistContactExtractor.parse_contact(tmp)
  end
end
