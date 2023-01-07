# frozen_string_literal: true

module Facturama
  module Models
    class Address < Model
      attr_accessor :Street,
                    :ExteriorNumber,
                    :InteriorNumber,
                    :Neighborhood,
                    :ZipCode,
                    :Locality,
                    :Municipality,
                    :State,
                    :Country
    end
  end
end
