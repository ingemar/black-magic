# Black Magic
Black magic attribute initialization.

Usage:
```ruby
require "black/magic"

class Demon
  attr_init(
    :name,
    :source,
  )
  .public(:name)
  .with_class_method_call(:summon)

  def summon
    puts "#{name} says 'bwoahahaha!'"
  end
end
demon = Demon.new(name: "Lucy", source: "fire")
demon.name
# => "Lucy"
demon.public_methods.include?(:source)
# => false
Demon.summon(name: "Lucy", source: "fire")
# Lucy says 'bwoahahaha!'
# => nil
```

## Do not
Be a rebel and run this in production or any other mission critical code, I dare you. 😜
