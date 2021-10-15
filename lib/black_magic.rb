require_relative "black_magic/invocation"
require_relative "black_magic/mixin"
require_relative "black_magic/version"

module BlackMagic
end

Module.include(BlackMagic::Mixin)
