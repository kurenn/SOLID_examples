# High-level modules should not depend on low-level modules. Both should depend on abstractions (e.g. interfaces).

class Server
  attr_accessor :provider

  def create
    Heroku.create
  end
end

# What if we needed to add another server, such as Digitalocean, GCP or AWS
