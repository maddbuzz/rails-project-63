# frozen_string_literal: true

module Elements
  class Submit < Element
    def initialize(value)
      super name: 'input', attributes: { type: 'submit', value: }
    end
  end
end
