#!/usr/bin/env ruby

require 'socket'

if server_pid = fork
  retries = 0
  sleep_time = 1

  begin
    sleep sleep_time
    socket = TCPSocket.new('localhost', 3000)
    socket.close
  rescue Errno::ECONNREFUSED
    retries += 1
    raise if retries > 5

    sleep_time += 1
    retry
  end

  system("npm test")
  npm_status = $?.exitstatus

  Process.kill("TERM", server_pid)
  Process.waitpid(server_pid)
  exit npm_status
else
  exec("bin/rails server")
end
