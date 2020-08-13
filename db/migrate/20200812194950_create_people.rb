class CreatePeople < ActiveRecord::Migration[5.2]
  def change
    create_table :people do |t|
      t.string :name
      t.string :email
      t.date :birthday
      t.string :country
      t.integer :rating

      t.timestamps
    end
  end
end
