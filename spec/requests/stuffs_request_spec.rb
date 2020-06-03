# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Stuffs', type: :request do
  let!(:user) { User.create(name: 'name') }
  let!(:stuff) { Stuff.create(name: 'stuff', user: user) }

  describe 'GET /api/v1/stuffs' do
    it 'is protected content' do
      get '/api/v1/stuffs'

      expect(response.status).to eq 401
    end

    it 'returns stuffs list for a user with access' do
      get '/api/v1/stuffs', headers: { 'Access-Token': user.token }

      expect(response.status).to eq 200
      expect(JSON.parse(response.body)).to eq [stuff.attributes.slice('id', 'name').as_json]
    end

    # it 'cannot use twice same token' do
    #   get '/api/v1/stuffs', headers: { access_token: user.token }

    #   expect(response.status).to eq 200

    #   last_valid_token = response.header['Access-Token']

    #   get '/api/v1/stuffs', headers: { access_token: user.token }

    #   expect(response.status).to eq 401
    #   expect(response.header['Access-Token']).to be_nil

    #   get '/api/v1/stuffs', headers: { access_token: last_valid_token }

    #   expect(response.status).to eq 200
    # end
  end

  describe 'POST /api/v1/stuffs' do
    let(:user) { User.create(name: 'name') }
    let(:stuff_params) { { 'name' => 'Civic', 'user_id' => user.id } }

    it 'is protected content' do
      get '/api/v1/stuffs', params: { stuff: stuff_params }

      expect(response.status).to eq 401
    end

    it 'creates a stuff' do
      post '/api/v1/stuffs', params: { stuff: stuff_params }, headers: { 'Access-Token': user.token }

      expect(response.status).to eq 201

      new_stuff = JSON.parse(response.body)

      expect(new_stuff.slice('id', 'name', 'user_id')).to eq(stuff_params.merge({ 'id' => Stuff.last.id }))
      expect(user.stuffs.count).to eq 2
    end
  end
end
