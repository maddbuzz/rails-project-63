# frozen_string_literal: true

require_relative 'hexlet_code/version'

module HexletCode
  class Error < StandardError; end

  module Tag
    def self.build(tag_name, attributes = {}, &block)
      attr_str = attributes.map { |k, v| " #{k}=\"#{v}\"" }.join
      if block_given?
        body = block.call
        "<#{tag_name}#{attr_str}>#{body}</#{tag_name}>"
      else
        "<#{tag_name}#{attr_str}>"
      end
    end
  end

  class Form
    def initialize(user, url, method, **kwargs)
      @user = user
      @url = url
      @method = method
      @other_attributes = kwargs
      @children = []
    end

    def input(name, as: nil, **kwargs)
      @children << { tag_name: 'label', attributes: { for: name }, body: name.capitalize }
      return textarea(name, **kwargs) if as == :text

      value = @user.public_send(name)
      @children << { tag_name: 'input', attributes: { name:, type: 'text', value:, **kwargs }, body: nil }
    end

    def textarea(name, **kwargs)
      default_params = { cols: '20', rows: '40' }
      params = default_params.merge(kwargs)
      value = @user.public_send(name)
      @children << { tag_name: 'textarea', attributes: { name:, **params }, body: value }
    end

    def submit(value = 'Save')
      @children << { tag_name: 'input', attributes: { type: 'submit', value: }, body: nil }
    end

    def build_template(template_builder)
      # template_builder.call(tag_name, attributes, &body)
      template_builder.call('form', action: @url, method: @method, **@other_attributes) do
        @children
          .map do |child|
            body = child[:body]
            block = body && proc { body }
            template_builder.call(child[:tag_name], child[:attributes], &block)
          end
          .join
      end
    end
  end

  def self.form_for(user, url: '#', method: 'post', **kwargs)
    form = Form.new user, url, method, **kwargs
    yield form
    template_builder = ->(tag_name, attributes, &body) { Tag.build(tag_name, attributes, &body) }
    form.build_template template_builder
  end
end
