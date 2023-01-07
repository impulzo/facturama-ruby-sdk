# frozen_string_literal: true

require_relative 'model_exception'

class FacturamaException < StandardError
  def initialize(exception_message, exception_details = nil)
    super exception_message

    @details = exception_details
  end

  attr_reader :details
end
