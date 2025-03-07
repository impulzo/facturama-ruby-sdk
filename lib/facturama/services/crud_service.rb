# frozen_string_literal: true

require_relative 'http_service'

module Facturama
  module Services
    class CrudService < HttpService
      def retrieve(message)
        HttpService.instance_method(:get).bind(self).call(message)
      end

      def list
        HttpService.instance_method(:get).bind(self).call('')
      end

      def create(message, url = '')
        HttpService.instance_method(:post).bind(self).call(message, url)
      end

      def create3(message, url = '')
        HttpService.instance_method(:post).bind(self).call(message, url)
      end

      def remove(message)
        HttpService.instance_method(:delete).bind(self).call(message)
      end

      def update(message, url = '')
        HttpService.instance_method(:put).bind(self).call(message, url)
      end
    end
  end
end
