# frozen_string_literal: true

module Elements
  class Text < Element
    def initialize(name, value, **kwargs)
      default_params = { cols: '20', rows: '40' }
      super name: 'textarea', attributes: { name:, **default_params, **kwargs }, content: value
    end
  end
end
