# frozen_string_literal: true

module Facturama
  module Models
    class Csd < Model
      attr_accessor :Rfc,
                    :Certificate,
                    :PrivateKey,
                    :PrivateKeyPassword

      validates :Certificate, :PrivateKey, :PrivateKeyPassword, presence: true
    end
  end
end
