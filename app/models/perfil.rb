class Perfil < ActiveRecord::Base
  validates_presence_of :descricao
  validates_uniqueness_of :descricao
  has_many :users, :class_name => "user", :foreign_key => "perfil_id"
  has_and_belongs_to_many :categorias
end
