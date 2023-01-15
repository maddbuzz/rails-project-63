# frozen_string_literal: true

require_relative 'hexlet_code/version'
autoload('Form', 'hexlet_code/form')
autoload('Tag', 'hexlet_code/tag')

module HexletCode
  class Error < StandardError; end

  def self.form_for(entity, url: '#', method: 'post', **kwargs)
    form = Form.new entity, attributes: { action: url, method:, **kwargs }
    yield form

    node = form.node
    Tag.build(node[:tag_name], node[:attributes]) do
      node[:body]
        .map do |child|
          node = child.node
          body = node[:body]
          block = body && proc { body }
          Tag.build(node[:tag_name], node[:attributes], &block)
        end
        .join
    end
  end
end
