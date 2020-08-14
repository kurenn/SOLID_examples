# if S is a subtype of T, then objects of type T may be replaced with objects of type S 
# (i.e. an object of type T may be substituted with any object of a subtype S) without
# altering any of the desirable properties of the program 

class Mammal
  def eat
  end

  def walk
  end
end

class Lion < Mammal
end

class Monkey < Mammal
end

def migrate
  mammals.each do |mammal|
    mammal.walk
  end
end
