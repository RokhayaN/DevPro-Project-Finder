class Engineer <ActiveRecord::Base
  has_secure_password 
  validates_presence_of :username,:email
  validates_uniqueness_of :username, :email
  has_many :projects 
end 