class BlogPostVersion < BlogPost
  belongs_to :original, class_name: "BlogPostOriginal",  foreign_key: "original_post_id"

  def is_version?
    true
  end

end
