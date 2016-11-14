App.feedChannel = App.cable.subscriptions.create { channel: "FeedChannel" },
  received: (data) ->
    if data["feed"]?
      $(".feed_#{data["feed"]}").html data["full_display"] if data["full_display"]?
      $(".feed_link_#{data["feed"]}").html data["link_display"] if data["link_display"]?
    else
      $(".feeds_full").append data["full_display"] if data["full_display"]?
      $(".feed_links").append data["link_display"] if data["link_display"]?
