require 'spec_helper'
describe Contato do
  subject { Contato.new }
  
  it { should validate_presence_of(:nome) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:assunto) }
  it { should validate_presence_of(:mensagem) } 
  
end