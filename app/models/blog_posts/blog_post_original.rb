class BlogPostOriginal < BlogPost
   has_many :versions, class_name: "BlogPostVersion",  foreign_key: "original_post_id"
  has_many :meta_properties, class_name: "MetaProperty", foreign_type: "BlogPostOriginal", foreign_key: 'owner_id', dependent: :destroy


 # after_create :set_meta_information

 # def set_meta_information
 #  page_information = PageInformation.create!(owner_type:"BlogPostLive", owner_id: self.id, editor_user_id: editor_user_id )
 #  page_information.make_default_properties
 # end

after_create :generate_default_ranking

def generate_default_ranking
  if self.scheduled?
    rank = rand(5..30)
    category = rand(1..2)
    if self.blog_post_rankings.where(category: category).blank?
      ranking= BlogPostRanking.create!(rank: rank, blog_post_id: self.id, category: category, start_date: published_datetime, 
      end_date: published_datetime + 7.day )
      puts "added ranking #{ranking.category} for #{self.title}"
    end
  end

end

end
