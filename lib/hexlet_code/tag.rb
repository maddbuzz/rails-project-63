# frozen_string_literal: true

module Tag
  def self.build(name, attributes = {}, &block_with_content)
    attr_str = attributes.map { |k, v| " #{k}=\"#{v}\"" }.join
    return "<#{name}#{attr_str}>" unless block_given?

    content = block_with_content.call
    "<#{name}#{attr_str}>#{content}</#{name}>"
  end
end
