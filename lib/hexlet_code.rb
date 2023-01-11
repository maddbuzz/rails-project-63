# frozen_string_literal: true

require_relative 'hexlet_code/version'

module HexletCode
  class Error < StandardError; end
  # Your code goes here...

  module Tag
    def self.build(tag_name, attributes = {})
      attrs = attributes.map { |k, v| " #{k}=\"#{v}\"" }
      "<#{tag_name}#{attrs.join}>"
    end
  end
end
