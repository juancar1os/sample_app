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
  
end
