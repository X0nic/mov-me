require 'fog'

class FeedBuilder
  def run()

    hash = {
      :provider                 => 'AWS',
      :aws_access_key_id        => Settings.aws_access_key_id,
      :aws_secret_access_key    => Settings.aws_secret_access_key
    }

    connection = Fog::Storage.new(hash)

    directory = connection.directories.get(Settings.s3_bucket)

    tmp_dir = "/tmp/#{Time.now.to_i}"
    FileUtils.mkdir_p tmp_dir
    Dir.chdir tmp_dir

    # Cast to array, since fog is strange and wont let me filter
    json_files = directory.files.to_a.select{ |a| File.extname(a.key) == ".json" }

    puts "Tmp dir: #{tmp_dir}"
    json_files.each do |json_file|
      puts "Writing #{json_file.key}"

      json = JSON.parse(json_file.body)
      # File.open(json_file.key, "w") { |file| file.write(json_file.body) }

      puts json["fulltitle"]
      puts json["description"]
      puts json["creator"]
      puts json["uploader_url"]
      puts json["upload_date"]
      puts Date.parse(json["upload_date"])
      puts json["webpage_url"]
    end

rss = <<-EOF
<?xml version="1.0" encoding="UTF-8"?>
<rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom">
  <channel>
    <title>Mov Me Feed</title>
  </channel>
</rss>
EOF

    puts rss
  end
end
#
# => ["upload_date", "creator", "height", "like_count", "duration", "fulltitle", "playlist_index", "view_count", "playlist",
#  "title", "_filename", "tags", "is_live", "id", "dislike_count", "average_rating", "abr", "uploader_url", "categories",
#  "fps", "stretched_ratio", "age_limit", "annotations", "webpage_url_basename", "acodec", "display_id", "automatic_captions", "description",
#  "format", "start_time", "uploader", "format_id", "uploader_id", "subtitles", "thumbnails", "license", "alt_title",
#  "extractor_key", "vcodec", "thumbnail", "vbr", "ext", "extractor", "end_time", "webpage_url", "formats",
#  "resolution", "width"]
