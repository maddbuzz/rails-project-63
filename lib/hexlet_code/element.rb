# frozen_string_literal: true

class Element
  def initialize(name:, attributes:, content: nil)
    @element = { name:, attributes:, content: }
  end

  attr_reader :element
end
