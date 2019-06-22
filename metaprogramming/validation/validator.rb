module Validation
  class Validator
    def initialize(attribute_name, *options)
      @attribute_name = attribute_name
      @options = options if options
    end
  end
end
