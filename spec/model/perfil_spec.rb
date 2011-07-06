#encoding: utf-8
require 'spec_helper'

describe Perfil do
  
  subject {Factory(:perfil)}
  
  it 'deveria validar a preseça da descrição' do
    should validate_presence_of(:descricao).with_message(/Campo obrigatório/)
  end
  
  it 'não deveria salvar com a mesma descrição' do
    should validate_uniqueness_of(:descricao).with_message(/Campo duplicado, informe outro/)
  end
  
end