# The job file that schedules the ingesting of RSS feeds.
#
# @author [ Kyle Ady, Tyler Hampton ]
# @since 0.0.2
class FeedsUpdateJob
  include SuckerPunch::Job

def perform(args)
  if args[:all]
    @feeds = Feed.all
    @feeds.each do |feed|
      FeedsUpdateJob.perform_async(id: feed.id)
    end
  elsif args[:id]
    Feed.find(args[:id]).update
  end
  if args[:continuous]
    FeedsUpdateJob.perform_in(300, args)
  end
end

end
