class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :name
      t.string :person_id
      t.string :person_name
      t.integer :group_id
      t.string :work

      t.timestamps null: false
    end
  end
end
