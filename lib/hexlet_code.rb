# frozen_string_literal: true

require_relative 'hexlet_code/version'

module HexletCode
  class Error < StandardError; end
  # Your code goes here...

  module Tag
    def self.build(tag_name, attributes = {})
      attrs = attributes.map { |k, v| " #{k}=\"#{v}\"" }
      if block_given?
        body = yield
        "<#{tag_name}#{attrs.join}>#{body}</#{tag_name}>"
      else
        "<#{tag_name}#{attrs.join}>"
      end
    end
  end

  def self.form_for(_user, url: '#')
    f = Tag.build('form', action: url, method: 'post') { '' }
    yield f
  end
end
