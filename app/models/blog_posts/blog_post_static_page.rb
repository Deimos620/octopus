class BlogPostStaticPage < BlogPost
  has_many :versions, class_name: "BlogPostVersion",  foreign_key: "original_post_id"
  has_many :meta_properties, class_name: "MetaProperty", foreign_type: "BlogPostStaticPage", foreign_key: 'owner_id', dependent: :destroy


end
