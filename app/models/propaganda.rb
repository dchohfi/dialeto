# encoding: utf-8
class Propaganda < ActiveRecord::Base
  
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
  
  validates_presence_of :nome, :nome => "Nome não pode ser vazio."
  validates_uniqueness_of :nome, :message => "Nome já cadastrado."
  validates_attachment_presence :image, :media
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
end
