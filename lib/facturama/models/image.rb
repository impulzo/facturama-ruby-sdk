# frozen_string_literal: true

module Facturama
  module Models
    class Image < Model
      attr_accessor :Image,
                    :Type

      validates :Image, presence: true
    end
  end
end
