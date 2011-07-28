#encoding: utf-8
require 'spec_helper'

describe Perfil do
  
  subject {Factory(:perfil)}
  
  it { should validate_presence_of(:descricao) }
  it { should validate_presence_of(:nome) }
  it { should validate_uniqueness_of(:nome).case_insensitive }
  it { should have_many(:users) }
  
end