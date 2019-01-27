require 'socket'

def headers(client)
  headers = []
  while header = client.gets
    break if header.chomp.empty?
    headers << header.chomp
  end
  headers
end

def response(client, headers)
  client.puts "HTTP/2.0 200 OK"
  client.puts "Content-Type: text/plain"
  client.puts
  routes = Routes.new
  routes.get('/hello')
  client.puts routes.match(headers.first)
  client.close
end


if $PROGRAM_NAME == __FILE__
  server = TCPServer.new 3000

  loop do
    Thread.start(server.accept) do |client|
      load './src/routes.rb'
      m_headers = headers(client)
      p [Thread.current, m_headers]
      response(client, m_headers)
    end
  end
end
