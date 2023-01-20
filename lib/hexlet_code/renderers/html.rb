# frozen_string_literal: true

autoload :Tag, 'hexlet_code/tag'

module Renderers
  module HTML
    def self.render(form)
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
end
