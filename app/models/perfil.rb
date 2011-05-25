class Perfil < ActiveRecord::Base
  attr_accessible :descricao
  validates_presence_of :descricao
  validates_uniqueness_of :descricao
end
