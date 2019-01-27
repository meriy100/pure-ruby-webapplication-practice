require 'socket'

def headers(client)
  headers = []
  while header = client.gets
    break if header.chomp.empty?
    headers << header.chomp
  end
  headers
end

def response(client)
  client.puts "HTTP/1.0 200 OK"
  client.puts "Content-Type: text/plain"
  client.puts
  client.puts "message body"
  client.close
end


if $PROGRAM_NAME == __FILE__
  server = TCPServer.new 3000

  loop do
    Thread.start(server.accept) do |client|
      p [Thread.current]
      m_headers = headers(client)
      p [Thread.current, m_headers]
      response(client)
    end
  end
end
