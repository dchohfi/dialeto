class User < ActiveRecord::Base
  belongs_to :perfil

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :token_authenticatable

  attr_accessible :email, :password, :password_confirmation, :remember_me, :perfil_id, :role

  ROLES = %w[admin user]
  
  def categorias
    categorias = []
    videos.each do |video|
      video.categorias.each{|categoria| 
        categorias << categoria unless categorias.index(categoria) != nil
      }
    end
    categorias
  end
 
  def videos
    perfil.videos
  end
    
end