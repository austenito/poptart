module Poptart
  class Root < Model
    def root_uri
      @root_uri = URI.parse(root.links.self.href)
    end

    def scheme
      root_uri.scheme
    end

    def host
      root_uri.port ? "#{root_uri.host}:#{root_uri.port}" : root_uri.host
    end
  end
end
