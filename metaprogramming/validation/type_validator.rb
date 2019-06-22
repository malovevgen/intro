module Validation
  class TypeValidator < Validator
    def validate(object)
      value = object.send(@attribute_name)
      expected_type = @options.first
      object.errors ||= []
      unless value.is_a?(expected_type)
        object.errors << [@attribute_name, "must be #{expected_type}"]
      end
    end
  end
end
