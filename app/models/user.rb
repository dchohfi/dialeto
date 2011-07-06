class User < ActiveRecord::Base
  attr_accessor :login
  
  belongs_to :perfil
  validates_presence_of :perfil, :message => "Selecione um perfil"
  validates_inclusion_of :role, :in => %w[admin user editor], :message => "Role %s não está incluso na lista"
  validates_uniqueness_of :username, :message => "Usuário já cadastrado"
  validates_uniqueness_of :email, :message => "Email já cadastrado"

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :token_authenticatable

  attr_accessible :email, :password, :password_confirmation, :remember_me, :perfil_id, :role, :username, :login

  ROLES = %w[admin user editor]
  
  protected
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
  end
    
end