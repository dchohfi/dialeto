class Video < ActiveRecord::Base
  attr_reader :categoria_tokens, :perfil_tokens
  attr_accessible :categoria_tokens, :perfil_tokens, :images_attributes, :nome, :media, :tag_list, :descricao, :panda_video_id
  
  scope :videos_do_usuario, lambda {|user|
    {
      :select => "DISTINCT videos.*",
      :joins => "LEFT JOIN perfis_videos pv ON pv.video_id = videos.id " +
                "LEFT JOIN perfis p ON pv.perfil_id = p.id " +
                "LEFT JOIN users u ON u.perfil_id = p.id",
      :conditions => ["u.id = ?", user], :group => "videos.id"
    }
  }
    
  acts_as_taggable_on :tags
  has_many :images, :as => :owner, :dependent => :destroy
  has_and_belongs_to_many :categorias, :join_table => "categorias_videos"
  has_and_belongs_to_many :perfis, :join_table => "perfis_videos"
  validates_inclusion_of :status, :in => %w[pending completed]
  validates_presence_of :nome, :perfis, :categorias, :images, :panda_video_id
  validates_uniqueness_of :nome, :case_sensitive => false

  accepts_nested_attributes_for :images, :reject_if => lambda { |t| t['image'].nil? }
  
  STATUS = %w[pending completed]
  
  def initialize(*params)
    super(*params)

    if (@new_record)
      self.status = 'pending'
    end
  end
  
  def panda_video
    @panda_video ||= Panda::Video.find(panda_video_id)
  end

  def images_url
    images_url = []
    images.each{|image| images_url << image.image_url}
    images_url
  end

  def authenticated_media_url(options={})
    return unless completed?
    options.reverse_merge! :expires_in => 10.minutes, :use_ssl => false
    AWS::S3::S3Object.url_for file_name << content_type, 'dialeto_video', options
  end
  
  def as_json(options)
    super(:only => [:id, :created_at, :nome, :updated_at, :descricao, :content_type, :file_size, :original_file_name], :methods => [:tag_list, :images_url, :authenticated_media_url], :include => {:categorias => {:only => [:id]}})
  end
  
  def categoria_tokens=(ids)
    self.categoria_ids = ids;
  end
  
  def perfil_tokens=(ids)
    self.perfil_ids = ids
  end
  
  def completed?
    self.status == 'completed'
  end
end
