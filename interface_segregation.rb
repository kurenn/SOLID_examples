# No client should be forced to depend on methods it does not use.

class Motorcycle
  def change_oil
  end

  def charge_battery
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