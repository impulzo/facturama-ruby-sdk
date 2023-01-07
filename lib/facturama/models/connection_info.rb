# frozen_string_literal: true

module Facturama
  module Models
    class ConnectionInfo
      # API Endpoints
      URL_DEV = 'https://apisandbox.facturama.mx'
      URL_PROD = 'https://api.facturama.mx'

      def initialize(facturama_user, facturama_password, is_development = true)
        @facturama_user = facturama_user
        @facturama_password = facturama_password
        @is_development = is_development

        @uri_base = is_development ? URL_DEV : URL_PROD
      end

      attr_reader :uri_base, :facturama_user, :facturama_password, :is_development
    end
  end
end
