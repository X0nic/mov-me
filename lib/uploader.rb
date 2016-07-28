require 'fog'

class Uploader
  def initialize(settings)
    @settings = settings
  end

  def run(mov_file)
    puts "Uploading: #{mov_file}"

    # create a connection
    hash = {
      :provider                 => 'AWS',
      :aws_access_key_id        => @settings.aws_access_key_id,
      :aws_secret_access_key    => @settings.aws_secret_access_key
    }

    connection = Fog::Storage.new(hash)

    directory = connection.directories.get(@settings.s3_bucket)

    # directory = connection.directories.create(
    #   :key    => @settings.s#_bucket, # globally unique name
    #   :public => true
    # )

    # list directories
    p connection.directories

    # upload that resume
    file = directory.files.create(
      :key    => mov_file,
      :body   => File.open(mov_file),
      :public => true
    )

    p file
    file
  rescue ex
    puts ex
  end
end
