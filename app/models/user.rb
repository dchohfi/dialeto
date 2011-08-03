class User < ActiveRecord::Base
  attr_accessor :login
  usar_como_cpf :cpf
  
  belongs_to :perfil
  
  validates_presence_of :cpf, :telefone, :nome, :nascimento, :endereco, :sexo, :role, :username, :perfil
  validates_inclusion_of :sexo, :in => %w[masculino feminino]
  validates_inclusion_of :role, :in => %w[admin user editor]
  validates_uniqueness_of :username, :case_sensitive => false
  validates_uniqueness_of :email, :case_sensitive => false

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :token_authenticatable

  attr_accessible :email, :password, :password_confirmation, :remember_me, :perfil_id, :role, :username, :login, :endereco, :telefone, :nome, :nascimento, :sexo, :cpf, :nascimento_str, :locked, :perfil

  ROLES = %w[admin user editor]
  SEXO = %w[masculino feminino]
  
  def nascimento_str
    self.nascimento.strftime('%d/%m/%Y') unless nascimento.nil?
  end

  def nascimento_str=(nascimento_str)
    self.nascimento = Date.strptime(nascimento_str, '%d/%m/%Y')
  rescue ArgumentError
    @nascimento_invalid = true
  end
  
  def active_for_authentication?
    !self.locked
  end
  
  protected
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
  end
    
end