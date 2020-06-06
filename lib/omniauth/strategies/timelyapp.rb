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

      #def request_phase
      #  req = Rack::Request.new(@env)
      #  options.update(req.params)
      #  ua = req.user_agent.to_s
      #  super
      #end

      #def auth_hash
      #  signed_value = access_token.params['id'] + access_token.params['issued_at']
      #  raw_expected_signature = OpenSSL::HMAC.digest('sha256', options.client_secret.to_s, signed_value)
      #  expected_signature = Base64.strict_encode64 raw_expected_signature
      #  signature = access_token.params['signature']
      #  fail! "TimelyApp user id did not match signature!" unless signature == expected_signature
      #  super
      #end

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
        #hash.merge!('refresh_token' => access_token.refresh_token) if access_token.refresh_token
        hash
      end

      def raw_info
        access_token.options[:mode] = :header
        p access_token
        @raw_info ||= access_token
      end

      extra do

      end

    end

  end
end
