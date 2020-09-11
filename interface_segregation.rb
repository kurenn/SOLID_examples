# No client should be forced to depend on methods it does not use.

class Motorcycle
end

class MotorcycleInternals
  def initialize(motorcycle)
  end

  def change_oil
  end

  def charge_battery
  end
end

class Rideable
  def initialize(motorcycle)
  end

  def drive
  end

  def adjust_mirror
  end
end

class Rider
end

class Mechanic
end