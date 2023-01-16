# frozen_string_literal: true

class Element
  attr_reader :element

  def initialize(tag_name:, attributes:, content: nil)
    @element = { tag_name:, attributes:, content: }
  end
end
