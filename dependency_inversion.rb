# High-level modules should not depend on low-level modules. Both should depend on abstractions (e.g. interfaces).

class Server
  def create
    Heroku.create
  end
end