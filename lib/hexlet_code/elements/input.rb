# frozen_string_literal: true

module Elements
  class Input < Element
    def initialize(name, value, **kwargs)
      super name: 'input', attributes: { name:, type: 'text', value:, **kwargs }
    end
  end
end
