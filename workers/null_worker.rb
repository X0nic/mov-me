require './app'
require './workers/config'

class NullWorker
  include Sidekiq::Worker
  def perform(sleep_time)
    puts "Sleeping for #{sleep_time}"
    sleep sleep_time
    puts "Done sleeping for #{sleep_time}"
  end
end
