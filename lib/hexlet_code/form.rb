# frozen_string_literal: true

autoload('Node', 'hexlet_code/node')

class Form < Node
  def initialize(entity, attributes:)
    @entity = entity
    super tag_name: 'form', attributes:, body: []
  end

  def input(name, as: :input, **kwargs)
    @node[:body] << Label.new(name)
    value = @entity.public_send(name)
    control_class = Form.const_get(as.capitalize)
    @node[:body] << control_class.new(name, value, **kwargs)
  end

  def submit(value = 'Save')
    @node[:body] << Submit.new(value)
  end

  class Submit < Node
    def initialize(value)
      super tag_name: 'input', attributes: { type: 'submit', value: }, body: nil
    end
  end

  class Label < Node
    def initialize(name)
      super tag_name: 'label', attributes: { for: name }, body: name.capitalize
    end
  end

  class Input < Node
    def initialize(name, value, **kwargs)
      super tag_name: 'input', attributes: { name:, type: 'text', value:, **kwargs }, body: nil
    end
  end

  class Text < Node
    def initialize(name, value, **kwargs)
      default_params = { cols: '20', rows: '40' }
      params = default_params.merge(kwargs)
      super tag_name: 'textarea', attributes: { name:, **params }, body: value
    end
  end
end
