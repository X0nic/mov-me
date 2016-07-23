class CommandRunner
  def exec(system_command)
    puts "Running: #{system_command}"
    system system_command
    puts "Ran: #{system_command}"
  end

  def exec_grab_output(system_command)
    puts "Running: #{system_command}"
    results = `#{system_command}`.strip
    puts "Ran: #{system_command}"
    results
  end
end
