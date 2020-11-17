# frozen_string_literal: true

class LandingController < ApplicationController
  def index
    render json: "Landing page"
  end
end
