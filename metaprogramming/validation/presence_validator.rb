module Validation
  class PresenceValidator < Validator
    def validate(object)
      value = object.send(@attribute_name)
      object.errors ||= []
      object.errors << "#{@attribute_name} must be present" if value.nil?
    end
  end
end
