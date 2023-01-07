# frozen_string_literal: true

module Facturama
  module Models
    require_relative 'product_tax'

    class Product < Model
      attr_accessor :Unit,
                    :UnitCode,
                    :IdentificationNumber,
                    :Name,
                    :Description,
                    :Price,
                    :CodeProdServ,
                    :CuentaPredial,
                    :Complement,
                    :Id,
                    :Taxes

      validates :Unit, :Name, :Description, :Price, presence: true
      # has_many_objects , :ProductTax
      # has_many_objects :Taxes, ProductTax
    end
  end
end
