class Settings
  def self.sms_enabled?
    boolean(config[:sms_enabled])
  end
  def self.account_sid
    config[:account_sid]
  end
  def self.auth_token
    config[:auth_token]
  end
  def self.messaging_service_sid
    config[:messaging_service_sid]
  end
  def self.bcc_to
    config[:bcc_to]
  end
  def self.s3_bucket
    config[:s3_bucket]
  end
  def self.aws_access_key_id
    config[:aws_access_key_id]
  end
  def self.aws_secret_access_key
    config[:aws_secret_access_key]
  end
  def self.sidekiq_username
    config[:sidekiq_username]
  end
  def self.sidekiq_password
    config[:sidekiq_password]
  end
  def self.redis_host
    config[:redis_host]
  end

  def self.loaded?
    !!config
  end

  private

  def self.config
    @config ||= load_config
  end

  def self.load_config
    file_name = File.exists?("config.local.yml") ? "config.local.yml" : "config.yml"
    file_path = File.join('config', file_name)

    document = ERB.new(IO.read(file_path)).result
    yaml = YAML.load(document) || {}
    yaml.symbolize_keys
  end

  def self.boolean(param)
    %("1","true").include?(param.downcase)
  end
end
