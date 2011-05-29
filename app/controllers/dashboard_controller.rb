class DashboardController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @users = User.all.delete_if {:id == current_user.id}
  end
end