class CreateSoftwareEngineers < ActiveRecord::Migration
  def change
  create_table  :engineers do |t|
      t.string  :first_name 
      t.string  :last_name 
      t.string  :username
      t.string  :email
      t.string  :password 
    end 
  end
end
