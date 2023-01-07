# frozen_string_literal: true

module Facturama
  module Models
    class Receiver < Model
      attr_accessor :Id,
                    :Rfc,
                    :Name,
                    :CfdiUse,
                    :TaxResidence,
                    :TaxRegistrationNumber,
                    :TaxZipCode,
                    :FiscalRegime

      validates :Rfc, presence: true
    end
  end
end
