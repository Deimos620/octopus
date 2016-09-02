class HeroUploader < DefaultUploader

 process :resize_to_fill => [1200 , 800]

  # Create different versions of your uploaded files:

  version :lg do
      process :resize_to_fill => [600, 400]
  end

  version :md do
      process :resize_to_fill => [300, 200]
  end

  version :sm do
      process :resize_to_fill => [150, 100]
  end

  version :twitter_card do 
      # <meta name="twitter:image:src" content="https://cdn0.vox-cdn.com/thumbor/8qgNd8-OAH5Wf7ohjXWfJW3jkIE=/23x0:767x419/1600x900/cdn0.vox-cdn.com/uploads/chorus_image/image/48777547/Screenshot_2016-02-10_09.11.51.0.0.png">
  end

  version :og_card do 
    process :resize_to_fill => [767, 419]
  end

  version :default_thumbnail do
      process :resize_to_fill => [300, 200]
  end


  

end
