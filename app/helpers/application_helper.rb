module ApplicationHelper
  def menu_principal
    return unless user_signed_in?
    menu = %w(Perfil Categoria Propaganda Video)
    menu_principal = "<ul class=\"topnav\">"
    menu.each do |item|
      menu_principal << "<li>" + link_to(item, :controller => item.downcase.pluralize) + "</li>"
    end
		if can? :manage, @users
			 	menu_principal << "<li class=\"right\"><a id=\"menu-usuario\" href=\"/dashboard\">Usuários</a></li>"
				menu_principal << "<li class=\"right\">" + link_to("Novo Usuário", new_user_path) + "</li>"
		end
    menu_principal << "</ul"
    raw menu_principal
  end
end
