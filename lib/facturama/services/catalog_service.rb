# frozen_string_literal: true

require_relative 'crud_service'

module Facturama
  module Services
    class CatalogService < CrudService
      def initialize(connection_info)
        super(connection_info, 'catalogs')
      end

      def units(keyword = nil)
        parameters = keyword.to_s.empty? ? '' : "?keyword=#{keyword}"
        get("units#{parameters}")
      end

      def name_ids
        get('NameIds')
      end

      def products_or_services(keyword)
        get("ProductsOrServices?keyword=#{keyword}")
      end

      def currencies(keyword = nil)
        parameters = keyword.to_s.empty? ? '' : "?keyword=#{keyword}"
        get("currencies#{parameters}")
      end

      def payment_forms
        get('paymentforms')
      end

      def payment_methods
        get('paymentmethods')
      end
    end
  end
end
