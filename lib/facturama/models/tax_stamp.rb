# frozen_string_literal: true

module Facturama
  module Models
    class TaxStamp < Model
      attr_accessor :Uuid,
                    :Date,
                    :CfdiSign,
                    :SatCertNumber,
                    :SatSign
    end
  end
end
