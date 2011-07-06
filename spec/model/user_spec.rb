#encoding: utf-8
require 'spec_helper'

describe User do
  before do
    @user_attr = Factory.attributes_for(:user)
    @usuario_valido = User.new(@user_attr)
    @perfil_valido = Factory(:perfil)
    @usuario_valido.perfil = @perfil_valido
    @usuario_valido.role = "admin"
    @usuario_valido.username = "Outro"
    @usuario_valido.email = "demo@demo.com"
    @usuario_valido.save
  end
  
  it 'não deve cadastrar um usuario sem perfil' do
    user = User.new(@user_attr)
    user.should_not be_valid
    user.errors.should_not be_empty
    user.should validate_presence_of(:perfil).with_message(/Selecione um perfil/)
  end
  
  it 'não deve cadastrar um usuario sem role' do
    user = User.new(@user_attr)
    user.perfil = @perfil_valido
    user.save
    user.should_not be_valid
    user.errors.should_not be_empty
    user.should_not allow_value(nil).for(:role)
  end
  
  it 'não deve cadastrar um usuario com role diferente de admin, user, editor' do
    user = User.new(@user_attr)
    user.perfil = @perfil_valido
    user.save
    user.should_not be_valid
    user.errors.should_not be_empty
    user.should_not allow_value("qualquer").for(:role)
  end
  
  it 'deveria cadastrar um usuario valido' do
    user = User.new(@user_attr)
    user.perfil = @perfil_valido
    user.role = "admin"
    user.save
    user.should be_valid
    user.errors.should be_empty
  end
  
  it 'não deve cadastrar um usuario com email duplicado' do
    @usuario_valido.should be_valid
    
    user = User.new(@user_attr)
    user.perfil = @perfil_valido
    user.email = "demo@demo.com"
    user.save
    user.should_not be_valid
    user.errors.should_not be_empty
    user.should validate_uniqueness_of(:email)
  end
  
  it 'não deve cadastrar um usuario com username duplicado' do
    @usuario_valido.should be_valid
    
    user = User.new(@user_attr)
    user.perfil = @perfil_valido
    user.username = "Outro"
    user.save
    user.should_not be_valid
    user.errors.should_not be_empty
    user.should validate_uniqueness_of(:username).with_message(/Usuário já cadastrado/)
  end
  
end