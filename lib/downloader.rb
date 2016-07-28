require "./lib/message"
require "./lib/command_runner"
require "./lib/uploader"

class Downloader
  def initialize(settings:)
    @settings = settings
  end

  def run(url:, to:)
    title = CommandRunner.new.exec_grab_output "youtube-dl --get-title #{url}"
    Message.new(@settings).send(message: "Found: #{title}", to: to)

    CommandRunner.new.exec "youtube-dl --add-metadata -f 'bestvideo[height<=480]+bestaudio/best[height<=480]' #{url}"
    Message.new(@settings).send(message: "Downloaded #{url}", to: to)

    id = CommandRunner.new.exec_grab_output "youtube-dl --get-id #{url}"
    filename = Dir.glob("*#{id}*").first
    Message.new(@settings).send(message: "Saved to: #{filename}", to: to)

    s3_file = Uploader.new(@settings).run(filename)

    Message.new(@settings).send(message: "Uploaded #{filename}", to: to)

    Message.new(@settings).send(message: s3_file.public_url, to: to)

    safe_url = URI.escape(s3_file.public_url)
    Message.new(@settings).send(message: "vlc-x-callback://x-callback-url/download?url=#{safe_url}", to: to)

    filename
  end

  def background_run(url)
    Thread.new do
      run(url)
    end
  end

end
