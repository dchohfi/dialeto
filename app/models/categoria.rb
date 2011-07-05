class Categoria < ActiveRecord::Base
  validates_presence_of :descricao
  validates_uniqueness_of :descricao
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