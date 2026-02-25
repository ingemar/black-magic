# frozen_string_literal: true

require "erb"

module BlackMagic
  class Invocation
    def self.call(klass, attributes)
      new(klass, attributes).invoke
    end

    def initialize(klass, attributes)
      @klass = klass
      @attributes = attributes
    end

    def invoke
      klass.class_eval(code)
      self
    end

    def with_class_method_call(method_name)
      klass.define_singleton_method(method_name) do |**attrs|
        new(**attrs).public_send(method_name)
      end
      self
    end

    def public(*attrs)
      klass.send(:public, attrs)
      self
    end

    private

    TEMPLATE = <<~ERB
      def initialize(%{attributes_kwargs})
        %{instance_variable_setters}
      end

      private

      attr_reader(%{attribute_names})
    ERB

    private_constant :TEMPLATE

    attr_reader :klass, :attributes

    def code
      attributes_kwargs = attributes.map { "#{it}:" }.join(", ")
      instance_variable_setters = attributes.map { "@#{it} = #{it}" }.join("\n")
      attribute_names = attributes.map { ":#{it}" }.join(", ")

      TEMPLATE % {attributes_kwargs:, instance_variable_setters:, attribute_names:}
    end
  end
end
