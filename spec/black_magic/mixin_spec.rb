require "spec_helper"

RSpec.describe BlackMagic::Mixin do
  describe ".attr_init" do
    it "calls the invocation class with the given attributes" do
      allow(BlackMagic::Invocation).to receive(:call)

      BlackMagic::Mixin.attr_init :attribute1, :attribute2

      expect(BlackMagic::Invocation).to have_received(:call).with(
        BlackMagic::Mixin,
        %i[attribute1 attribute2]
      )
    end
  end
end
