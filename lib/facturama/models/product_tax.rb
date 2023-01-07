# frozen_string_literal: true

module Facturama
  module Models
    class ProductTax < Model
      attr_accessor :Name,
                    :Rate,
                    :IsRetention,
                    :IsFederalTax,
                    :IsQuota,
                    :Total
    end
  end
end
