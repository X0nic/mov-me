require './app'
require './workers/config'

class DownloadWorker
  include Sidekiq::Worker
  def perform(url, to)
    Downloader.new.run(url: url, to: to)
  end
end
