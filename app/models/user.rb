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

class User < ActiveRecord::Base
  attr_accessible :nombre, :email
  
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :nombre,  :presence => true,
                      :length => { :maximum => 50 }
  validates :email, :presence => true,
                    :format => { :with => email_regex },
                    :uniqueness => { :case_sensitive => false}
end
