# == Schema Information
# Schema version: 20110203175406
#
# Table name: users
#
#  id         :integer(4)      not null, primary key
#  nombre     :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#
require 'digest'

class User < ActiveRecord::Base
  attr_accessor :password
  attr_accessible :nombre, :email, :password, :password_confirmation
  
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :nombre,  :presence => true,
                      :length => { :maximum => 50 }
  validates :email, :presence => true,
                    :format => { :with => email_regex, :message => "invalido" },
                    :uniqueness => { :case_sensitive => false}
                    
  #Crear el artribubto virtual para confirmar el password 'password_confirmation'
  validates :password,  :presence =>true, 
                        :confirmation => true, 
                        :length => { :within => 6..40, :message => "Tu password es muy corta (minimo 6 caracteres)" }
  
  #Crear el atributo para encriptar el password          
  before_save :encrypt_password
  
  #True si el password del User es igual al password provisto
  def has_password?(submitted_password)
    # Comparar encrypted_password con la version encriptada de submitted_password
    encrypted_password == encrypt(submitted_password)
  end
  
  def self.authenticate(email, submitted_password)
    user = find_by_email(email)
    return nil if user.nil?
    return user if user.has_password?(submitted_password)
  end
  
  def self.authenticate_with_salt(id, cookie_salt)
      user = find_by_id(id)
      (user && user.salt == cookie_salt) ? user : nil
  end
  
  private
  
    #Delega la creación del password al método encrypt
    def encrypt_password
      self.salt = make_salt if new_record?
      self.encrypted_password = encrypt(self.password)
    end
    
    #Agrega el salt al string del password a encriptar y lo encripta
    def encrypt(string)
      secure_hash("#{salt}--#{string}")
    end
    
    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end
    
    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end
                        
end
