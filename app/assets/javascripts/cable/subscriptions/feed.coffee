App.feedChannel = App.cable.subscriptions.create { channel: "FeedChannel" },
  received: (data) ->
    if data["refresh_all"]
      $(".feed_links").html data["display"]
    else
      $(".feed_links").append data["display"]
