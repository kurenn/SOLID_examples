# High-level modules should not depend on low-level modules. Both should depend on abstractions (e.g. interfaces).

class Server
  attr_accessor :provider

  def initialize(provider:)
    @provider = provider
  end

  def create
    ServerCreator.new(self).perform
  end
end

# What if we needed to add another server, such as Digitalocean, GCP or AWS

module Hosting
  class Heroku
    def create
      Heroku.create
    end
  end

  class AWS
    def create
      node = AWS.create
      node.setup_ssh_access
    end
  end
end

class ServerCreator
  def initialize(server)
    @server = server
  end

  def perform
    provider_klass = "Hosting::#{server.provider.classify}".constantize
    provider_klass.new.create
  end
end

ServerCreator.new(Server.new(provider: "heroku")).perform