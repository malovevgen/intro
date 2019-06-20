module Validation
  def validate attribute_name, validator, *options
    @@validators ||= []
    @@validators << { attribute_name: attribute_name, validator: validator, options: options }

    define_method :validate! do
      errors = validate
      raise errors.first unless errors.empty?
    end

    define_method :valid? do
      errors = validate
      errors.empty?
    end

    define_method :validate do
      errors = []
      @@validators.each do |validator|
        value = send(validator[:attribute_name])
        case validator[:validator]
        when :presence
          errors << "#{validator[:attribute_name]} must be present" if value.nil?
        when :format
          errors << "#{validator[:attribute_name]} have wrong format" unless value =~ validator[:options][0]
        when :type
          errors << "#{validator[:attribute_name]} have wrong type" unless value.is_a? validator[:options][0]
        end
      end
      errors
    end
  end
end
