 # string: contenido
 # id: user_id
 #
class Micropost < ActiveRecord::Base
  #Permitir que desde web solo se acceda a 'contenido'
  attr_accessible :contenido
  
  #Un micropost solo puede pertenecer a un usuario
  belongs_to :user
  
  #Validaciones
  validates :contenido, :presence => true, :length => { :maximum => 145 }
  validates :contenido, :presence => true
  
  #Ordenar del más reciente al más antiguo
  default_scope :order => 'microposts.created_at DESC'
  
  # Regresa los iTuits de los usuarios que el usuario dado sigue
  scope :from_users_followed_by, lambda { |user| followed_by(user) }
  
  
  #Obtener la lista de los Microposts de cierto usuario
  #def self.from_users_followed_by(user)
    #Mapa de usuarios que user sigue
    #followed_ids = user.following.map(&:id).join(", ")
    #where("user_id IN (#{followed_ids}) OR user_id = ?", user)
  #end
  
  private 
  
    def self.followed_by(user)
      followed_ids = %(SELECT followed_id FROM relationships WHERE follower_id = :user_id)
      where("user_id IN (#{followed_ids}) OR user_id = :user_id", 
		{ :user_id => user })
    end
  
  
end
