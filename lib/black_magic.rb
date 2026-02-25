# frozen_string_literal: true

require_relative "black_magic/invocation"
require_relative "black_magic/version"

module BlackMagic
  def attr_init(*attributes)
    BlackMagic::Invocation.call(self, attributes)
  end
end

Class.include(BlackMagic)
