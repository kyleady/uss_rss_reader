class FeedsUpdateJob
  include SuckerPunch::Job

  def perform(args)
    puts "\n\n\nUpdating\n\n\n"
    @feeds = Feed.all
    @feeds.each do |feed|
      feed.update
    end
    puts "\n\n\nUpdate Complete"
    puts args
    if args[:continuous]
      FeedsUpdateJob.perform_in(300,{continuous: true})
    end
  end
end
