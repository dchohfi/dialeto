class Video < ActiveRecord::Base
  include S3Module
  before_save :create_job
  
  has_and_belongs_to_many :categorias, :join_table => "videos_categorias"
  belongs_to :perfil, :class_name => "Perfil", :foreign_key => "perfil_id"
  validates_associated :perfil
  validates_presence_of :perfil_id, :message => "Selecione um perfil."
  validates_presence_of :nome, :message => "Digite um nome."
  validates_presence_of :local_path, :message => "Selecione um arquivo."
  validates_uniqueness_of :nome, :message => "Nome duplicado, informe outro."
  validates_uniqueness_of :local_path, :message => "Arquivo duplicado, informe outro."
end
