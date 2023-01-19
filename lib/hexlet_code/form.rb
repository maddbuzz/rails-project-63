# frozen_string_literal: true

autoload :Element, 'hexlet_code/element'
autoload :Elements, 'hexlet_code/elements'

class Form < Element
  def initialize(entity, attributes:)
    @entity = entity
    super name: 'form', attributes:, content: []
  end

  def input(name, as: :input, **kwargs)
    @element[:content] << Elements::Label.new(name)
    value = @entity.public_send(name)
    control_class = Elements.const_get(as.capitalize)
    @element[:content] << control_class.new(name, value, **kwargs)
  end

  def submit(value = 'Save')
    @element[:content] << Elements::Submit.new(value)
  end
end
