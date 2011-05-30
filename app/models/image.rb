class Image < ActiveRecord::Base
  
  has_attached_file :image,
      :storage => :s3,
      :s3_credentials => "#{RAILS_ROOT}/config/s3.yml",
      :path => ":attachment/:id/:style/:basename.:extension",
      :bucket => 'dialeto_video_thumb'
  
  belongs_to :video, :class_name => "Video", :foreign_key => "video_id"
  validates_attachment_presence :image
  
  def image_url
    image.url
  end
end
