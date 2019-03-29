require 'socket'
require 'json'

def headers(client)
  headers = []
  while header = client.gets
    break if header.chomp.empty?
    headers << header.chomp
  end
  headers
end

def response(client, headers)
  case headers.first
  when %r{^GET /book.json}
    client.puts "HTTP/2.0 200 OK"
    client.puts "Content-Type: application/json;"
    client.puts "Access-Control-Allow-Origin: *"

    client.puts
    client.puts({ data: { name: 'elm が分かる本', author: 'わい' } }.to_json)
  when %r{^GET /test.json}
    client.puts "HTTP/2.0 200 OK"
    client.puts "Content-Type: application/json;"
    client.puts "Access-Control-Allow-Origin: *"

    client.puts
    client.puts File.read('./output.json')
  when %r{^GET /}
    client.puts "HTTP/2.0 200 OK"
    client.puts "Content-Type: text/plain;"
    client.puts "Access-Control-Allow-Origin: *"

    client.puts
    client.puts "hello"
  end
  client.close
end


if $PROGRAM_NAME == __FILE__
  server = TCPServer.new 4000

  loop do
    Thread.start(server.accept) do |client|
      load './src/routes.rb'
      m_headers = headers(client)
      p [Thread.current, m_headers]
      response(client, m_headers)
    end
  end
end
