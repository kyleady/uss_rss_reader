App.articleChannel = App.cable.subscriptions.create { channel: "ArticleChannel" },
  received: (data) ->
    if data["article"]?
      $(".article_#{data["article"]}").html data["full_display"] if data["full_display"]?
      $(".article_link_#{data["article"]}").html data["link_display"] if data["link_display"]?
    else if data["feed"]?
      $(".articles_#{data["feed"]}").append data["full_display"] if data["full_display"]?
      $(".article_links_#{data["feed"]}").append data["link_display"] if data["link_display"]?
      if data["unread"]
        $(".articles_unread").append data["full_display"] if data["full_display"]?
        $(".article_links_unread").append data["link_display"] if data["link_display"]?
