# Run Shell Commands From Ruby
#

require_relative 'log'

def shell( command )
  log.prompt command
  # To display output as it comes AND store output:
  # http://stackoverflow.com/questions/10224481/running-a-command-from-ruby-displaying-and-capturing-the-output
  output = ""
  r, io = IO.pipe
  fork do
    system(command, out: io, err: :out)
  end
  io.close
  r.each_char{|c| print c; output += c}
  return output
end

# Alternative:
# Just print as a whole:
#
# def shell( command )
# output = `#{command}`
# print output
# end
