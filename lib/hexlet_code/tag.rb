# frozen_string_literal: true

module Tag
  def self.build(tag_name, attributes = {}, &block)
    attr_str = attributes.map { |k, v| " #{k}=\"#{v}\"" }.join
    return "<#{tag_name}#{attr_str}>" unless block_given?

    content = block.call
    "<#{tag_name}#{attr_str}>#{content}</#{tag_name}>"
  end
end
