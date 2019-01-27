class Routes
  attr_accessor :routes

  def initialize
    self.routes = []
  end

  def get(path)
    case path
    when String
      routes.push([path, :get])
    end
  end

  def match(header)
    routes.select { |_, method| method == request_method(header) }.find do |path, _|
      path == request_path(header)
    end
  end

  def request_method(header)
    case header
    when /\AGET/
      :get
    when /\APOST/
      :post
    end
  end

  def request_path(header)
    if m = header.match(%r{\A[A-Z]+ (/hello)})
      m[1]
    end
  end
end
