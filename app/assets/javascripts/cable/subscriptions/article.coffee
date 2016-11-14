App.articleChannel = App.cable.subscriptions.create { channel: "ArticleChannel" },
  received: (data) ->
    if data["article"]?
      if data["full_display"]?
        $(".article_#{data["article"]}").html data["full_display"]
      if data["link_display"]?
        $(".article_link_#{data["article"]}").html data["link_display"]
    else if data["feed"]?
      if data["full_display"]?
        $(".articles_#{data["feed"]}").append data["full_display"]
      if data["link_display"]?
        $(".article_links_#{data["feed"]}").append data["link_display"]
      if data["unread"]
        if data["full_display"]?
          $(".articles_unread").append data["full_display"]
        if data["link_display"]?
          $(".article_links_unread").append data["link_display"]
