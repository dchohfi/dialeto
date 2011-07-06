#encoding: utf-8
require 'spec_helper'

describe User do
  
  subject {Factory(:user)}
  
  it 'não deve cadastrar um usuario sem perfil' do
    should validate_presence_of(:perfil).with_message(/Selecione um perfil/)
  end
  
  it 'não deve cadastrar um usuario sem role' do
    should_not allow_value(nil).for(:role)
  end
  
  it 'não deve cadastrar um usuario com role diferente de admin, user, editor' do
    should_not allow_value("qualquer").for(:role)
  end
  
  it 'não deve cadastrar um usuario com email duplicado' do
    should validate_uniqueness_of(:email).case_insensitive
  end
  
  it 'não deve cadastrar um usuario com username duplicado' do
    should validate_uniqueness_of(:username).case_insensitive.with_message(/Usuário já cadastrado/)
  end
  
end