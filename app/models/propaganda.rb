# encoding: utf-8
class Propaganda < ActiveRecord::Base
  
  has_attached_file :image,
      :storage => :s3,
      :s3_credentials => "#{RAILS_ROOT}/config/s3.yml",
      :path => "/:style/:id/:filename",
      :bucket => 'dialeto_propaganda'
  
  validates_presence_of :nome, :nome => "Nome não pode ser nulo"
  validates_uniqueness_of :nome, :message => "Nome já cadastrado"
  validates_attachment_presence :image

  has_and_belongs_to_many :categorias
  
  def image_url
    image.url
  end
end
