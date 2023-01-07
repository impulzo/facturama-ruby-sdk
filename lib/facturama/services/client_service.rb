# frozen_string_literal: true

require_relative 'crud_service'

module Facturama
  module Services
    class ClientService < CrudService
      def initialize(connection_info)
        super(connection_info, 'client')
      end
    end
  end
end
