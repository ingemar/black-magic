module BlackMagic
  module Mixin
    def attr_init(*attributes)
      BlackMagic::Invocation.call(self, attributes)
    end
  end
end
