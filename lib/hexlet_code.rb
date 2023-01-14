# frozen_string_literal: true

require_relative 'hexlet_code/version'

module HexletCode
  class Error < StandardError; end

  module Tag
    def self.build(tag_name, attributes = {}, &block)
      attr_str = attributes.map { |k, v| " #{k}=\"#{v}\"" }.join
      return "<#{tag_name}#{attr_str}>" unless block_given?

      content = block.call
      body =
        if content.instance_of?(Array)
          content
            .map do |child|
              child_body = child[:body]
              child_block = child_body && proc { child_body }
              build(child[:tag_name], child[:attributes], &child_block)
            end
            .join
        else
          content
        end
      "<#{tag_name}#{attr_str}>#{body}</#{tag_name}>"
    end
  end

  class Form
    attr_reader :model

    def initialize(entity, attributes:)
      @entity = entity
      @model = { tag_name: 'form', attributes:, body: [] }
    end

    def submit(value = 'Save')
      @model[:body] << { tag_name: 'input', attributes: { type: 'submit', value: }, body: nil }
    end

    def input(name, as: nil, **kwargs)
      @model[:body] << { tag_name: 'label', attributes: { for: name }, body: name.capitalize }
      return textarea(name, **kwargs) if as == :text

      value = @entity.public_send(name)
      @model[:body] << { tag_name: 'input', attributes: { name:, type: 'text', value:, **kwargs }, body: nil }
    end

    private

    def textarea(name, **kwargs)
      default_params = { cols: '20', rows: '40' }
      params = default_params.merge(kwargs)
      value = @entity.public_send(name)
      @model[:body] << { tag_name: 'textarea', attributes: { name:, **params }, body: value }
    end
  end

  def self.form_for(entity, url: '#', method: 'post', **kwargs)
    form = Form.new entity, attributes: { action: url, method:, **kwargs }
    yield form
    model = form.model
    Tag.build(model[:tag_name], model[:attributes]) { model[:body] }
  end
end
