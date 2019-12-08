class CreateProjects < ActiveRecord::Migration
  def change
  create_table :projects do |t|
     t.string  :name 
     t.string  :content 
     t.string  :fuctionality
     t.integer :engineer_id
   end 
  end
end
