# frozen_string_literal: true

Dir["#{Rails.root}/lib/warden/*.rb"].sort.each { |file| require file }
Warden::Strategies.add(:token, Warden::Strategies::TokenStrategy)
