class Categoria < ActiveRecord::Base
  scope :categorias_do_usuario, lambda {|user|
    {
      :select => "DISTINCT categorias.*",
      :joins => "LEFT JOIN categorias_videos cv ON cv.categoria_id = categorias.id " +
                "LEFT JOIN videos v ON cv.video_id = v.id " + 
                "LEFT JOIN perfis_videos pv ON pv.video_id = v.id " + 
                "LEFT JOIN perfis p ON pv.perfil_id = p.id " + 
                "LEFT JOIN users u ON u.perfil_id = p.id",
      :conditions => ["u.id = ?", user]
    }  
  }
  
  validates_presence_of :descricao, :nome, :images
  validates_uniqueness_of :nome
  has_and_belongs_to_many :videos, :join_table => "categorias_videos"
  has_many :images, :as => :owner, :dependent => :destroy

  accepts_nested_attributes_for :images, :reject_if => lambda { |t| t['image'].nil? }

  has_and_belongs_to_many :propagandas
  
  def images_url
    images_url = []
    images.each{|image| images_url << image.image_url}
    images_url
  end
  
  def as_json(options)
    super({:methods => [:images_url]})
  end
  
end