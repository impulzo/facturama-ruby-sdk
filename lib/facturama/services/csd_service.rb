# frozen_string_literal: true

require_relative 'crud_service'

module Facturama
  module Services
    class CsdService < CrudService
      def initialize(connection_info)
        super(connection_info, 'api-lite/csds')
      end
    end
  end
end
