# encoding: utf-8
class Image < ActiveRecord::Base
  
  has_attached_file :image,
      :storage => :s3,
      :s3_credentials => "#{Rails.root.to_s}/config/s3.yml",
      :path => ":attachment/:id/:style/:basename.:extension",
      :bucket => 'dialeto_video_thumb'
  
  belongs_to :owner, :polymorphic => true
  validates_attachment_presence :image
  validates_attachment_content_type :image, 
                                    :content_type => ["image/jpeg", "image/png", "image/gif"], 
                                    :message => "Formato de arquivo não suportado."
  
  def image_url
    image.url
  end
end
