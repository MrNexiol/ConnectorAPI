# frozen_string_literal: true

class ContactsController < ApplicationController
  def index
    render json: 'Index action'
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
