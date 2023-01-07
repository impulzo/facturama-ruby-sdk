# frozen_string_literal: true

module Facturama
  module Models
    class BranchOffice < Model
      attr_accessor :Id,
                    :Name,
                    :Description

      # :Address

      validates :Name, :Description, :Address, presence: true
      has_one_object :Address
    end
  end
end
