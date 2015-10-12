class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
    	t.string :title
    	t.text :description

    	t.references :group
    	t.references :user

    	t.timestamps
    end
  end
end
