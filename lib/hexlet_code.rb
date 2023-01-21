# frozen_string_literal: true

require_relative 'hexlet_code/version'
autoload :Form, 'hexlet_code/form'
autoload :FormRenderers, 'hexlet_code/form_renderers'

module HexletCode
  class Error < StandardError; end

  def self.form_for(entity, url: '#', method: 'post', **kwargs)
    form = Form.new entity, attributes: { action: url, method:, **kwargs }
    yield form
    FormRenderers::HTML.render(form)
  end
end
