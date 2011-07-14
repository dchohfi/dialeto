#encoding: utf-8
require 'spec_helper'

describe Perfil do
  
  subject {Factory(:perfil)}
  
  it 'deveria validar a preseça da descrição' do
    should validate_presence_of(:descricao)
  end
  
  it 'deveria validar a preseça do nome' do
    should validate_presence_of(:nome)
  end
  
  it 'não deveria salvar com a mesma descrição' do
    should validates_uniqueness_of(:nome)
  end
  
end