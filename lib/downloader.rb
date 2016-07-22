require "./lib/message"
require "./lib/command_runner"

class Downloader
  def initialize(settings)
    @settings = settings
  end

  def run(mov_url)
    Thread.new do
      CommandRunner.new.exec "youtube-dl #{mov_url}"
      Message.new(@settings).send("Downloaded #{mov_url}")
    end
  end
end
