# frozen_string_literal: true

class Api::V1::AuthenticationController < Api::V1::ApiController
  def login
    # Obviously its a better idea to find a user by username & password in the params.
    # using ID just for show
    render json: User.find(params[:id]).attributes.slice('token')
  end
end
