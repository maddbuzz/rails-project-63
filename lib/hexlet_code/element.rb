# frozen_string_literal: true

class Element
  attr_reader :element

  def initialize(name:, attributes:, content: nil)
    @element = { name:, attributes:, content: }
  end
end
