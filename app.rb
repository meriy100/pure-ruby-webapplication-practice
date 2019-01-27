require 'socket'

if $PROGRAM_NAME == __FILE__
  server = TCPServer.new 3000

  loop do
  client = server.accept
    headers = []
    while header = client.gets
      break if header.chomp.empty?
      headers << header.chomp
    end
    p headers

    client.puts "HTTP/1.0 200 OK"
    client.puts "Content-Type: text/plain"
    client.puts
    client.puts "message body"
    client.close
  end
end