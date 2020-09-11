# No client should be forced to depend on methods it does not use.

class Motorcycle
  include Rideable
  include OilChangeable
  include Chargeable
end

class ElectricBike
  include Rideable
  include Chargeable
end

module OilChangeable
  def change_oil
  end
end

module Chargeable
  def remove_seat
  end

  def charge_battery
  end
end

module Rideable
  def drive
  end

  def adjust_mirror
  end
end

class Rider
end

class Mechanic
  def change_oil(oil_changeable)
    oil_changeable.change_oil
  end

  def charge_battery(chargeable)
    if chargeable.respond_to? :charge_battery
      chargeable.remove_seat
      chargeable.charge_battery
    else
      raise StandardError, "Object must be Chargeable"
    end
  end
end