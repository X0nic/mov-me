require "./lib/message"
require "./lib/command_runner"

class Downloader
  def initialize(settings)
    @settings = settings
  end

  def run(message)
    Thread.new do
      CommandRunner.new.exec "sleep 10"
      Message.new(@settings).send(message)
    end
  end
end
