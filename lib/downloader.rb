require "./lib/message"

class Downloader
  def initialize(settings)
    @settings = settings
  end

  def run(message)
    Message.new(@settings).send(message)
  end
end
