module Accessors
  def attr_accessor_with_history(*args)
    args.each do |attribute_name|
      define_method(attribute_name) { instance_variable_get("@#{attribute_name}") }

      define_method("#{attribute_name}=") do |value|
        instance_variable_set("@#{attribute_name}", value)
        history = instance_variable_get("@#{attribute_name}_history") || [nil]
        history << value
        instance_variable_set("@#{attribute_name}_history", history)
      end

      define_method("#{attribute_name}_history") { instance_variable_get("@#{attribute_name}_history") }
    end
  end

  def strong_attr_accessor(attribute_name, type)
    define_method(attribute_name) { instance_variable_get("@#{attribute_name}") }

    define_method("#{attribute_name}=") do |value|
      if value.is_a? type
        instance_variable_set("@#{attribute_name}", value)
      else
        raise ArgumentError.new("ожидается значение типа #{type}")
      end
    end
  end
end
