# The job file that schedules the ingesting of RSS feeds.
#
# @author [ Kyle Ady, Tyler Hampton ]
# @since 0.0.2
class FeedsUpdateJob
  include SuckerPunch::Job

  def perform(args)
    @feeds = Feed.all

    @feeds.each(&:update)

    FeedsUpdateJob.perform_in(300, continuous: true) if args[:continuous]
  end
end
