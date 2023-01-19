# frozen_string_literal: true

require_relative 'hexlet_code/version'
autoload :Form, 'hexlet_code/form'
autoload :Tag, 'hexlet_code/tag'

module HexletCode
  class Error < StandardError; end

  def self.form_for(entity, url: '#', method: 'post', **kwargs)
    form = Form.new entity, attributes: { action: url, method:, **kwargs }
    yield form

    element = form.element
    Tag.build(element[:name], element[:attributes]) do
      element[:content]
        .map do |child|
          element = child.element
          content = element[:content]
          block = content && proc { content }
          Tag.build(element[:name], element[:attributes], &block)
        end
        .join
    end
  end
end
