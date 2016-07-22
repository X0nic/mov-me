class CommandRunner
  def exec(system_command)
    puts "Running: #{system_command}"
    system system_command
    puts "Ran: #{system_command}"
  end
end
