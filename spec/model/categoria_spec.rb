#encoding: utf-8
require 'spec_helper'

describe Categoria do
  
  subject {Factory(:categoria)}
  
  it { should validate_presence_of(:descricao) }
  it { should validate_presence_of(:nome) }
  it { should validate_presence_of(:images) }
  it { should validate_uniqueness_of(:nome) }
  it { should have_many(:images) }
  it { should have_many(:users) }
end