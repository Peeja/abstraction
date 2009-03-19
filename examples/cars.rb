$: << File.join(File.dirname(__FILE__), '..', 'lib')
require 'abstraction'

class Car
  abstract
end

class Convertible < Car
  def door_count
    2
  end
end

class Sedan < Car
  def door_count
    4
  end
end

# Either of these will raise an error, because Car is abstract.

# Car.new
# Car.allocate


# These cause no problems.

Convertible.new
Convertible.allocate

Sedan.new
Sedan.allocate
