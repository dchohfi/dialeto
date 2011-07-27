class Video < ActiveRecord::Base
  attr_reader :categoria_tokens, :perfil_tokens
  attr_accessible :categoria_tokens, :perfil_tokens, :images_attributes, :nome, :media, :tag_list, :descricao
  
  scope :videos_do_usuario, lambda {|user|
    {
      :select => "DISTINCT videos.*",
      :joins => query_videos_usuarios,
      :conditions => ["u.id = ?", user], :group => "videos.id"
    }
  }
  
  scope :videos_dos_usuarios, lambda {|users|
    {
      :select => "DISTINCT videos.*",
      :joins => query_videos_usuarios,
      :conditions => ["u.id IN (?)", users], :group => "videos.id"
    }
  }
  
  scope :videos_da_categoria, lambda {|categoria|
    {
      :select => "DISTINCT videos.*",
      :joins => "INNER JOIN categorias_videos cv ON cv.video_id = videos.id " +
                "INNER JOIN categorias c ON c.id = cv.categoria_id",
      :conditions => ["c.id = ?", categoria]
    }
  }
    
  
  has_attached_file :media,
      :storage => :s3,
      :s3_credentials => "#{Rails.root.to_s}/config/s3.yml",
      :s3_permissions => :private,
      :path => "/:style/:id/:filename",
      :bucket => 'dialeto_video'
    
  acts_as_taggable_on :tags
  has_many :images, :as => :owner, :dependent => :destroy
  has_and_belongs_to_many :categorias, :join_table => "categorias_videos"
  has_and_belongs_to_many :perfis, :join_table => "perfis_videos"
  
  validates_presence_of :nome, :message => "Campo obrigatório"
  validates_uniqueness_of :nome, :message => "Campo duplicado, informe outro"
  validates_attachment_presence :media
  validate :possui_categoria?
  validate :possui_perfil?

  accepts_nested_attributes_for :images, :reject_if => lambda { |t| t['image'].nil? }
  
  protected
  def self.query_videos_usuarios
    "LEFT JOIN perfis_videos pv ON pv.video_id = videos.id " +
              "LEFT JOIN perfis p ON pv.perfil_id = p.id " +
              "LEFT JOIN users u ON u.perfil_id = p.id"
  end
  def possui_perfil?
    errors.add_to_base "Adicione um perfil" if self.perfis.blank? or self.perfil_ids.blank?
  end
  def possui_categoria?
    errors.add_to_base "Adicione uma categoria" if self.categorias.blank? or self.categoria_ids.blank?
  end
  
  public
  def images_url
    images_url = []
    images.each{|image| images_url << image.image_url}
    images_url
  end

  def authenticated_media_url(options={})
    options.reverse_merge! :expires_in => 10.minutes, :use_ssl => false
    AWS::S3::S3Object.url_for media.path, media.options[:bucket], options
  end
  
  def as_json(options)
    super(:only => [:id, :created_at, :nome, :updated_at, :descricao, :media_content_type, :media_file_size, :media_file_name], :methods => [:tag_list, :images_url, :authenticated_media_url], :include => {:categorias => {:only => [:id]}})
  end
  
  def categoria_tokens=(ids)
    self.categoria_ids = ids;
  end
  def perfil_tokens=(ids)
    self.perfil_ids = ids
  end
end
