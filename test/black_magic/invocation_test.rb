# frozen_string_literal: true

require "test_helper"

class InvocationTest < Minitest::Test
  describe ".call" do
    it "initializes a new object and calls #invoke" do
      klass = Class.new

      BlackMagic::Invocation.call(klass, %i[attribute1 attribute2])

      object = klass.new(attribute1: "1", attribute2: "2")
      assert_equal "1", object.instance_variable_get(:@attribute1)
      assert_equal "2", object.instance_variable_get(:@attribute2)
    end
  end

  describe "#invoke" do
    it "defines initialization setters on the given class" do
      klass = Class.new
      invoker = BlackMagic::Invocation.new(klass, %i[attribute1 attribute2])

      invoker.invoke

      object = klass.new(attribute1: "1", attribute2: "2")
      assert_equal "1", object.instance_variable_get(:@attribute1)
      assert_equal "2", object.instance_variable_get(:@attribute2)
    end

    it "returns itself" do
      klass = Class.new
      invoker = BlackMagic::Invocation.new(klass, %i[attribute1 attribute2])

      result = invoker.invoke

      assert_equal invoker, result
    end
  end

  describe "#with_class_method_call" do
    it "defines a class method with the given name" do
      klass = Class.new
      invoker = BlackMagic::Invocation.new(klass, %i[attribute1 attribute2])

      invoker.with_class_method_call(:test_method)

      assert_respond_to klass, :test_method
    end

    it "creates a class method that instantiates and calls the named method" do
      klass = Class.new do
        def test_method
          [@attribute1, @attribute2]
        end
      end
      invoker = BlackMagic::Invocation.new(klass, %i[attribute1 attribute2])
      invoker.invoke.with_class_method_call(:test_method)

      result = klass.test_method(attribute1: "1", attribute2: "2")

      assert_equal ["1", "2"], result
    end

    it "returns itself" do
      klass = Class.new
      invoker = BlackMagic::Invocation.new(klass, %i[attribute1 attribute2])

      result = invoker.with_class_method_call(:test_method)

      assert_equal invoker, result
    end
  end

  describe "#public" do
    it "makes the given attributes public" do
      klass = Class.new
      invoker = BlackMagic::Invocation.new(klass, %i[attribute1 attribute2])
      invoker.invoke

      invoker.public(:attribute1, :attribute2)

      object = klass.new(attribute1: "1", attribute2: "2")
      assert_includes object.public_methods, :attribute1
      assert_includes object.public_methods, :attribute2
    end

    it "returns itself" do
      klass = Class.new
      invoker = BlackMagic::Invocation.new(klass, %i[attribute1 attribute2])

      result = invoker.invoke.public(:attribute1)

      assert_equal invoker, result
    end
  end
end
