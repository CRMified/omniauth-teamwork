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
        unless @info
          @info = raw_info
        end

        @info
      end

      def token
        access_token.token
      end

      credentials do
        hash = {'token' => access_token.token}
        hash
      end

      def raw_info
        access_token.options[:mode] = :header
        installation_url = access_token.params['installation']['apiEndPoint']
        @raw_info ||= access_token.get("#{installation_url}/me.json")
      end

      extra do
        raw_info.merge({
        'install' => access_token.params['installation'],
        })
      end

    end

  end
end
