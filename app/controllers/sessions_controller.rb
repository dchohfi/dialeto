class SessionsController < Devise::SessionsController
  
  def create
    logger.info(params)
    resource = warden.authenticate!(:scope => resource_name)
    logger.info(resource)
    logger.info('aqui')
    return sign_in_and_redirect(resource_name, resource)
  end
  
  def sign_in_and_redirect(resource_or_scope, resource=nil)
    logger.info('AQUIAQUIAUQI')
    logger.info('AQUIAQUIAUQI')
    logger.info('AQUIAQUIAUQI')
    
    scope = Devise::Mapping.find_scope!(resource_or_scope)
    resource ||= resource_or_scope
    sign_in(scope, resource) unless warden.user(scope) == resource
    return render :json => current_user.authentication_token
  end

  def failure
    return render:json => {:success => false, :errors => ["Login failed."]}
  end
end

