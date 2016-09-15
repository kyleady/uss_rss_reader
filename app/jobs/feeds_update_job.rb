require 'article.rb'

# The job file that schedules the ingesting of RSS feeds.
#
# @author [ Kyle Ady, Tyler Hampton ]
# @since 0.0.2
class FeedsUpdateJob
  include SuckerPunch::Job

  def perform(args)
    if args[:all]
      @feeds = Feed.all
      @feeds.each { |feed| FeedsUpdateJob.perform_async(id: feed.id) }
    elsif args[:id]
      Feed.find(args[:id]).update
    end

    FeedsUpdateJob.perform_in(300, args) if args[:continuous]
  end
end
