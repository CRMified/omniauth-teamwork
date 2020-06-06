require 'omniauth-oauth2'
require 'openssl'
require 'base64'

module OmniAuth
  module Strategies
    class Teamwork < OmniAuth::Strategies::OAuth2

      option :client_options, {
        :site          => 'https://www.teamwork.com',
        :authorize_url => '/launchpad/login',
        :token_url     => '/launchpad/v1/token.json',
        :grant_type    => 'code'
      }
      option :authorize_options, [
        :redirect_uri,
        :grant_type
      ]

      uid { raw_info['id'] }

      info do
        {
          :name => raw_info['name'],
          :email => raw_info['email-address']
        }
      end

      def token
        access_token.token
      end

      credentials do
        hash = {'token' => access_token.token}
        hash
      end

      def raw_info
        @raw_info ||= access_token.get('/me.json').parsed['person']
      end

      extra do
        {
          'raw_info' => raw_info
        }
      end

    end

  end
end
