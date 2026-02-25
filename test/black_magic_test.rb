# frozen_string_literal: true

require "test_helper"

class BlackMagicTest < Minitest::Test
  describe ".attr_init" do
    it "sets up attribute initialization on the extending class" do
      klass = Class.new

      klass.attr_init :attribute1, :attribute2

      object = klass.new(attribute1: "1", attribute2: "2")
      assert_equal "1", object.instance_variable_get(:@attribute1)
      assert_equal "2", object.instance_variable_get(:@attribute2)
    end
  end
end
