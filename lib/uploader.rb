require 'fog'

class Uploader
  def run(file_to_upload)
    puts "Uploading: #{file_to_upload}"

    hash = {
      :provider                 => 'AWS',
      :aws_access_key_id        => Settings.aws_access_key_id,
      :aws_secret_access_key    => Settings.aws_secret_access_key
    }

    connection = Fog::Storage.new(hash)

    directory = connection.directories.get(Settings.s3_bucket)

    file = directory.files.create(
      :key    => file_to_upload,
      :body   => File.open(file_to_upload),
      :public => true
    )

    file
  end
end
