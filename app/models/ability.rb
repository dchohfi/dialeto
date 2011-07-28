class Ability
  include CanCan::Ability
  
  def self.dominio
    [Categoria, Image, Perfil, Propaganda, Video]
  end
  
  def initialize(user)
    user ||= User.new
    can :manage, :all if user.role == "admin"
    can :manage, Ability.dominio  if user.role == "editor"
    can :read, Ability.dominio if user.role == "user"
  end
end