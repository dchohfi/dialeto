class Video < ActiveRecord::Base
  
  has_attached_file :media,
      :storage => :s3,
      :s3_credentials => "#{Rails.root.to_s}/config/s3.yml", :s3_protocol => 'https',
      :s3_permissions => :private,
      :path => "/:style/:id/:filename",
      :bucket => 'dialeto_video'
    
  acts_as_taggable_on :tags
  has_many :images, :as => :owner, :dependent => :destroy
  has_and_belongs_to_many :categorias, :join_table => "categorias_videos"
  has_and_belongs_to_many :perfis, :join_table => "perfis_videos"
  
  validates_presence_of :nome, :message => "Digite um nome."
  validates_uniqueness_of :nome, :message => "Nome duplicado, informe outro."
  accepts_nested_attributes_for :images, :reject_if => lambda { |t| t['image'].nil? }
  validates_attachment_presence :media
  
  def images_url
    images_url = []
    images.each{|image| images_url << image.image_url}
    images_url
  end

  def authenticated_media_url(options={})
    options.reverse_merge! :expires_in => 10.minutes, :use_ssl => true
    AWS::S3::S3Object.url_for media.path, media.options[:bucket], options
  end
  
  def as_json(options)
    super(:only => [:created_at, :nome, :updated_at], :methods => [:tag_list, :images_url, :authenticated_media_url], :include => {:categorias => {:only => [:id]}})
  end
  
end
