module ApplicationHelper
  def menu_principal
    return unless user_signed_in?
    menu = %w(Perfil Categoria Propaganda Video)
    menu_principal = ""
    menu.each do |item|
      menu_principal << link_to(item, :controller => item.downcase.pluralize) + " | "
    end
    raw menu_principal
  end
end
