require "spec_helper"

RSpec.describe BlackMagic::Invocation do
  describe ".call" do
    it "initializes a new object and call `#invoke`" do
      klass = Class.new

      BlackMagic::Invocation.call(klass, %i[attribute1 attribute2])

      object = klass.new(attribute1: "1", attribute2: "2")
      expect(object.instance_variable_get(:@attribute1)).to eq("1")
      expect(object.instance_variable_get(:@attribute2)).to eq("2")
    end
  end

  describe "#invoke" do
    it "defines initialization setters on the given class" do
      klass = Class.new
      invoker = BlackMagic::Invocation.new(klass, %i[attribute1 attribute2])

      invoker.invoke

      object = klass.new(attribute1: "1", attribute2: "2")
      expect(object.instance_variable_get(:@attribute1)).to eq("1")
      expect(object.instance_variable_get(:@attribute2)).to eq("2")
    end

    it "returns itself" do
      klass = Class.new
      invoker = BlackMagic::Invocation.new(klass, %i[attribute1 attribute2])

      result = invoker.invoke

      expect(result).to eq(invoker)
    end
  end

  describe "#with_class_method_call" do
    it "defines a class method with the given name" do
      klass = Class.new
      invoker = BlackMagic::Invocation.new(klass, %i[attribute1 attribute2])

      invoker.with_class_method_call(:test_method)

      expect(klass).to respond_to(:test_method)
    end

    it "initializes a new object of the class and call a method with the given name" do
      klass = Class.new
      object_double = double
      allow(klass).to receive(:new).and_return(object_double)
      allow(object_double).to receive(:test_method)
      invoker = BlackMagic::Invocation.new(klass, %i[attribute1 attribute2])
      invoker.invoke.with_class_method_call(:test_method)

      klass.test_method(attribute1: "1", attribute2: "2")

      expect(klass).to have_received(:new).with(
        attribute1: "1",
        attribute2: "2"
      )
      expect(object_double).to have_received(:test_method)
    end

    it "returns itself" do
      klass = Class.new
      invoker = BlackMagic::Invocation.new(klass, %i[attribute1 attribute2])

      result = invoker.with_class_method_call(:test_method)

      expect(result).to eq(invoker)
    end
  end

  describe "#public" do
    it "makes the given attributes public" do
      klass = Class.new
      invoker = BlackMagic::Invocation.new(klass, %i[attribute1 attribute2])
      invoker.invoke

      invoker.public(:attribute1, :attribute2)

      object = klass.new(attribute1: "1", attribute2: "2")
      expect(object.public_methods).to include(:attribute1, :attribute2)
    end

    it "returns itself" do
      klass = Class.new
      invoker = BlackMagic::Invocation.new(klass, %i[attribute1 attribute2])

      result = invoker.invoke.public(:attribute1)

      expect(result).to eq(invoker)
    end
  end
end
