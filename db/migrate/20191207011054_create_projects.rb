class CreateProjects < ActiveRecord::Migration
  def change
  create_table :projects do |t|
     t.string  :name 
     t.string  :content 
     t.string  :fuctionality
   end 
  end
end
