class Ability
  include CanCan::Ability
  
  def initialize(user)
    user ||= User.new
    dominio = [Categoria, Image, Perfil, Propaganda, Video]
    can :manage, :all if user.role == "admin"
    can :manage, dominio  if user.role == "editor"
    can :read, dominio if user.role == "user"
  end
end