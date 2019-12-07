class CreateSkills < ActiveRecord::Migration
  def change
  create_table :skills do |t|
     t.string  :degree  
     t.integer :experience  
     t.string  :projects
     t.string  :communication_skills
     t.string  :work_ethic
   end 
  end
end
