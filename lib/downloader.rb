require "./lib/message"
require "./lib/command_runner"
require "./lib/uploader"

class Downloader
  def run(url:, to:)
    title = CommandRunner.new.exec_grab_output "youtube-dl --get-title #{url}"
    Message.new.send(message: "Found: #{title}", to: to)

    id = CommandRunner.new.exec_grab_output "youtube-dl --get-id #{url}"

    save_location = "/tmp/#{id}"
    FileUtils.mkdir_p(save_location)
    Dir.chdir(save_location)

    CommandRunner.new.exec "youtube-dl --write-info-json --add-metadata #{url}"
    Message.new.send(message: "Downloaded #{url}", to: to)

    Message.new.send(message: "Saved to: #{movie_filename}", to: to)

    s3_file = Uploader.new.run(movie_filename)

    Message.new.send(message: "Uploaded #{movie_filename}", to: to)

    Message.new.send(message: s3_file.public_url, to: to)

    Uploader.new.run(json_filename)

    safe_url = URI.escape(s3_file.public_url)
    Message.new.send(message: "vlc-x-callback://x-callback-url/download?url=#{safe_url}", to: to)

    movie_filename
  end

  def movie_filename
    Dir["*"].find{ |file| File.extname(file) != ".json" }
  end

  def json_filename
    Dir["*.json"].first
  end

end
