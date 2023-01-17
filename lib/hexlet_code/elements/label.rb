# frozen_string_literal: true

module Elements
  class Label < Element
    def initialize(name)
      super name: 'label', attributes: { for: name }, content: name.capitalize
    end
  end
end
