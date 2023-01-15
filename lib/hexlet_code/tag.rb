# frozen_string_literal: true

module Tag
  def self.build(tag_name, attributes = {}, &block)
    attr_str = attributes.map { |k, v| " #{k}=\"#{v}\"" }.join
    return "<#{tag_name}#{attr_str}>" unless block_given?

    content = block.call
    return "<#{tag_name}#{attr_str}>#{content}</#{tag_name}>" unless content.instance_of?(Array)

    children =
      content
      .map do |child|
        node = child.node
        body = node[:body]
        block = body && proc { body }
        build(node[:tag_name], node[:attributes], &block)
      end
      .join
    "<#{tag_name}#{attr_str}>#{children}</#{tag_name}>"
  end
end
