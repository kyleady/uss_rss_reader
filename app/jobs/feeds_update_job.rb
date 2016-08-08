class FeedsUpdateJob
  include SuckerPunch::Job

  def perform
    puts "\n\n\nUpdating\n\n\n"
    @feeds = Feed.all
    @feeds.each do |feed|
      feed.update
    end
    puts "\n\n\nUpdate Complete\n\n\n"
    FeedsUpdateJob.perform_in(300)
  end
end
