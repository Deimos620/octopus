module BlogHelper

  def popular_articles
    BlogPostRanking.includes(:blog_post).current_as_of(Date.today).popular.order(rank: :desc)

  end

  def featured_articles
    BlogPostRanking.includes(:blog_post).current_as_of(Date.today).featured.order(rank: :desc)
  end

  def newest_articles
    BlogPost.new_this_month.order(published_datetime: :desc)
  end
end
