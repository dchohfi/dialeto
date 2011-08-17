# encoding: utf-8
class Propaganda < ActiveRecord::Base
  attr_reader :categoria_tokens
  attr_accessible :categoria_tokens, :nome, :image, :media
  
  scope :with_out_categoria, where("#{quoted_table_name}.id NOT IN (SELECT `categorias_propagandas`.propaganda_id FROM `categorias_propagandas`)")
    
  has_attached_file :image,
    :storage => :s3,
    :s3_credentials => "#{Rails.root.to_s}/config/s3.yml",
    :path => "/:style/:id/:filename",
    :bucket => 'dialeto_propaganda'
    
  has_attached_file :media,
      :storage => :s3,
      :s3_credentials => "#{Rails.root.to_s}/config/s3.yml",
      :path => "/:style/:id/:filename",
      :bucket => 'dialeto_propaganda'
  
  validates_presence_of :nome
  validates_uniqueness_of :nome, :case_sensitive => false
  validates_attachment_presence :image
  validates_attachment_presence :media
  validates_attachment_content_type :media, 
                                    :content_type => ["image/jpeg", "image/png", "image/gif"], 
                                    :message => "Formato de arquivo não suportado."
  validates_attachment_content_type :image, 
                                    :content_type => ["image/jpeg", "image/png", "image/gif"], 
                                    :message => "Formato de arquivo não suportado."

  has_and_belongs_to_many :categorias
    
  def image_url
    image.url
  end
  
  def media_url
    media.url
  end
  
  def as_json(options)
    super({:except => [:image_updated_at, :media_updated_at], :methods => [:image_url, :media_url] })
  end
  
  def categoria_tokens=(ids)
    self.categoria_ids = ids.split(",")
  end
end
