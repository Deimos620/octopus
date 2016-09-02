class MetaPropertyCategory < ActiveRecord::Base
  has_many :meta_properties, dependent: :destroy
  # has_many :page_informations, through: :meta_properties

  KINDS = [:unknown, :default, :open_graph, :twitter]
  LABELS = [:unset, :title, :description, :keywords, :site_name, :image,
              :type, :url, :twitter_card,   :twitter_site]
  enum kind: KINDS
  enum label: LABELS


  scope :default, -> { where(kind: "1") } 



  def is_title?
    label == 'title'
  end

  def is_description?
    label == 'description'
  end

  def is_image?
    label == 'image'
  end

  def is_url?
    label == 'url'
  end

  def is_site_name?
    label == 'site_name'
  end

  def is_type?
    label == 'type'
  end

  def is_twitter_card?
    label == 'twitter_card'
  end

  def is_twitter_site?
    label == 'twitter_site'
  end

  def is_keywords?
    label == 'keywords'
  end

end
