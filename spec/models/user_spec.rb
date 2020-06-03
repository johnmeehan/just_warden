# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it 'has secure token' do
    expect(User.create(name: 'name').token).to be_present
  end
end
