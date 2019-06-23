module Validation
  class FormatValidator < Validator
    def validate(object)
      value = object.send(@attribute_name)
      expected_format = @options.first
      object.errors ||= []
      return if value =~ expected_format

      error = "#{@attribute_name} must be in format #{expected_format}"
      object.errors << error
    end
  end
end
