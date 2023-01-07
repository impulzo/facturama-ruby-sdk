# frozen_string_literal: true

module Facturama
  module Models
    class CfdiRelation < Model
      attr_accessor :Uuid

      validates :Uuid, presence: true
    end
  end
end
