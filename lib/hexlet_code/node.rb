# frozen_string_literal: true

class Node
  attr_reader :node

  def initialize(tag_name:, attributes:, body: nil)
    @node = { tag_name:, attributes:, body: }
  end
end
