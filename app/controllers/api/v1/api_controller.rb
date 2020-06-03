# frozen_string_literal: true

# require_relative '../../../lib/warden/helper_methods'

class Api::V1::ApiController < ApplicationController
  include Warden::HelperMethods
end
