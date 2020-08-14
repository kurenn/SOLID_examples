# if S is a subtype of T, then objects of type T may be replaced with objects of type S 
# (i.e. an object of type T may be substituted with any object of a subtype S) without
# altering any of the desirable properties of the program 

class Mammal
  def eat
  end

  def walk
  end

  def can_walk?
    true
  end
end

class Lion < Mammal
end

class Monkey < Mammal
end

class Whale < Mammal
  def can_walk?
    false
  end

  def swim
  end
end

class Bat < Mammal
  def can_walk?
    false
  end

  def fly
  end
end

def migrate
  mammals.each do |mammal|
    if mammal.can_walk?
      mammal.walk
    end
  end
end
