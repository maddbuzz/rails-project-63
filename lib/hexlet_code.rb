# frozen_string_literal: true

require_relative 'hexlet_code/version'
autoload('Form', 'hexlet_code/form')
autoload('Tag', 'hexlet_code/tag')

module HexletCode
  class Error < StandardError; end

  def self.form_for(entity, url: '#', method: 'post', **kwargs)
    form = Form.new entity, attributes: { action: url, method:, **kwargs }
    yield form if block_given?
    node = form.node
    Tag.build(node[:tag_name], node[:attributes]) { node[:body] }
  end
end
