require 'spec_helper'
require "cancan/matchers"
describe Ability do
  
  before :each do
    @user = User.create
    @user.save(:validate => false)
  end

  it "validar regras de usuario" do
    @user.role = 'admin'
    ability = Ability.new(@user)
    ability.should be_able_to(:manage, :all)
  end
  
  it "validar regras de editor" do
    @user.role = 'admin'
    ability = Ability.new(@user)
    ability.should be_able_to(:manage, Ability.dominio)
  end
  
  it "validar regras de usuario" do
    @user.role = 'user'
    ability = Ability.new(@user)
    ability.should_not be_able_to(:manage, :all)
  end
  
end