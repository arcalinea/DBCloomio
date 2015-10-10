class Notes < ActiveRecord::Migration

  def change
  	create_table :notes do |t|
  		t.string :title
  		t.string :description
  	end
  end
  
end
