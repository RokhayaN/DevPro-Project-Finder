 class Project < ActiveRecord::Base
   has_secure_password
    validates_presence_of :username
    validates_presence_of :email
   belongs_to :engineer 
 end 