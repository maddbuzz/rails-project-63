# frozen_string_literal: true

module Tag
  def self.build(name, attributes = {})
    attr_str = attributes.map { |k, v| " #{k}=\"#{v}\"" }.join
    return "<#{name}#{attr_str}>" unless block_given?

    "<#{name}#{attr_str}>#{yield}</#{name}>"
  end
end
