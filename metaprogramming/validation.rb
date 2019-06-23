require_relative 'validation/validator'
require_relative 'validation/presence_validator'
require_relative 'validation/format_validator'
require_relative 'validation/type_validator'
module Validation
  def self.inluded(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end
end

module ClassMethods
  attr_accessor :validators

  def validate(attribute_name, validator_name, *options)
    validator_class_name = "#{validator_name.to_s.capitalize}Validator"
    validator_class = Validation.const_get(validator_class_name)
    validator = validator_class.new(attribute_name, options)

    self.validators ||= []
    self.validators << validator
  end
end

module InstanceMethods
  attr_accessor :errors

  def validate!
    validate
    raise errors.first unless errors.empty?
  end

  def valid?
    validate
    errors.empty?
  end

  def validate
    errors = []
    self.class.validators.each { |v| v.validate(self) }
    errors
  end
end
