# if S is a subtype of T, then objects of type T may be replaced with objects of type S 
# (i.e. an object of type T may be substituted with any object of a subtype S) without
# altering any of the desirable properties of the program 

class Mammal
  def eat
  end
end


module SwimmingMammal
  def swim
  end
end

module FlyingMammal
  def fly
  end
end

class Lion < Mammal
end

class Monkey < Mammal
end

class Whale < Mammal
  include SwimmingMammal
end

class Seal < Mammal
  include SwimmingMammal
end

class Bat < Mammal
  include FlyingMammal
end

def migrate
  mammals.each do |mammal|
    mammal.walk
  end
end
