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
      klass.define_singleton_method(method_name) do |**args|
        new(**args).public_send(method_name)
      end
      self
    end

    def public(*args)
      klass.send(:public, args)
      self
    end

    private

    TEMPLATE = <<~ERB.freeze
      def initialize(
        <%- attributes.each do |attribute| -%>
          <%= attribute %>:<%= ',' unless attribute == attributes.last %>
        <%- end -%>
      )
      <%- attributes.each do |attribute| -%>
        @<%= attribute %> = <%= attribute %>
      <%- end -%>
      end

      private

      attr_reader(
      <%- attributes.each do |attribute| -%>
        :<%= attribute %>,
      <%- end -%>
      )
    ERB

    private_constant :TEMPLATE

    attr_reader :klass, :attributes

    def code
      ::ERB.new(TEMPLATE, trim_mode: "-").result(env)
    end

    def env
      binding.tap { |b| b.local_variable_set(:attributes, attributes) }
    end
  end
end
