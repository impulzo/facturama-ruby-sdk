# frozen_string_literal: true

module Facturama
  module Models
    class CfdiRelations < Model
      attr_accessor :Type,
                    :Cfdis

      validates :Type, :Cfdis, presence: true
      has_many_objects :Cfdis, :CfdiRelation
    end
  end
end
