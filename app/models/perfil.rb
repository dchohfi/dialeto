class Perfil < ActiveRecord::Base
  validates_presence_of :descricao, :message => "Campo obrigatório"
  validates_uniqueness_of :descricao, :message => "Campo duplicado, informe outro"
  has_many :users
  has_and_belongs_to_many :videos, :join_table => "perfis_videos"
end