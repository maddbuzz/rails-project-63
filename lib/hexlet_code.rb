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

  class Form
    def initialize(user, url, method, **kwargs)
      @user = user
      @url = url
      @method = method
      @other_attributes = kwargs
      @children = []
    end

    def input(name, as: nil, **kwargs)
      @children << Tag.build('label', for: name) { name.capitalize }
      return textarea(name, **kwargs) if as == :text

      value = @user.public_send(name)
      @children << Tag.build('input', name:, type: 'text', value:, **kwargs)
    end

    def textarea(name, **kwargs)
      default_params = { cols: '20', rows: '40' }
      params = default_params.merge(kwargs)
      value = @user.public_send(name)
      @children << Tag.build('textarea', name:, **params) { value }
    end

    def submit(value = 'Save')
      @children << Tag.build('input', type: 'submit', value:)
    end

    def to_s
      Tag.build('form', action: @url, method: @method, **@other_attributes) do
        @children.join
      end
    end
  end

  def self.form_for(user, url: '#', method: 'post', **kwargs)
    form = Form.new user, url, method, **kwargs
    yield form
    form.to_s
  end
end
