# frozen_string_literal: true

class Api::V1::StuffsController < Api::V1::ApiController
  prepend_before_action :authenticate!

  def index
    # current_user.stuffs
    #  use a serializer like active model serializers
    render json: Stuff.select(:id, :name)
  end

  def create
    stuff = current_user.stuffs.create(stuffs_params)
    render json: stuff, status: :created
  end

  protected

  def stuffs_params
    params.require(:stuff).permit(:name, :user_id)
  end
end
