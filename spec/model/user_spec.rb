#encoding: utf-8
require 'spec_helper'

describe User do
  
  subject {Factory(:user)}
  
  it { should validate_presence_of(:perfil) }
  it { should validate_presence_of(:telefone) }
  it { should validate_presence_of(:nome) }
  it { should validate_presence_of(:nascimento) }
  it { should validate_presence_of(:endereco) }
  it { should validate_presence_of(:sexo) }
  it { should validate_presence_of(:role) }
  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:perfil) }
  it { should allow_value("admin").for(:role) }
  it { should allow_value("editor").for(:role) }
  it { should allow_value("user").for(:role) }
  it { should_not allow_value(nil).for(:role) }
  it { should_not allow_value("qualquer").for(:role) }
  it { should allow_value("masculino").for(:sexo) }
  it { should allow_value("feminino").for(:sexo) }
  it { should_not allow_value(nil).for(:sexo) }
  it { should_not allow_value("qualquer").for(:sexo) }
  it { should validate_uniqueness_of(:email).case_insensitive }
  it { should validate_uniqueness_of(:username).case_insensitive }
  it { should belong_to(:perfil) }
  
end