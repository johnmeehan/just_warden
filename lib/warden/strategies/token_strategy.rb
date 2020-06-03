# frozen_string_literal: true

require 'warden'
# https://github.com/wardencommunity/warden/blob/master/lib/warden/strategies/base.rb
module Warden
  module Strategies
    class TokenStrategy < ::Warden::Strategies::Base
      # The valid method should return true or false depending on if the strategy is a valid one for the request.
      def valid?
        access_token.present?
      end

      # Must be declared!
      def authenticate!
        user = User.find_by(token: access_token)

        if user
          # token && token.active?
          # if you need to regenerate the token do it here
          # user.regenerate_token
          success!(user)
        else
          fail!('Bad Token: Could not log in')
        end
      end

      private

      def access_token
        @access_token ||= request.get_header('HTTP_ACCESS_TOKEN')
      end
    end
  end
end
