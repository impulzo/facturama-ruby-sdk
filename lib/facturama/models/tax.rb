# frozen_string_literal: true

module Facturama
  module Models
    class Tax < Model
      attr_accessor :Total,
                    :Name,
                    :Base,
                    :Rate,
                    :Type,
                    :IsRetention,
                    :IsQuota
    end
  end
end
